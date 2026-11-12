# MIT License
#
# Copyright (c) 2026 Sergey Arkhipov
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from __future__ import annotations

import abc
import binascii
import contextlib
import dataclasses
import functools
import graphlib
import hashlib
import hmac
import itertools
import logging
import os
import pathlib
import subprocess
import tempfile
import typing as t


MODULE_CONFIG_NAME: t.Final = ".9s"
LOG: t.Final = logging.getLogger(__name__)


@dataclasses.dataclass(frozen=True, kw_only=True)
class Config:
    leaf: str = dataclasses.field(default="")
    install: str = dataclasses.field(default="")
    uninstall: str = dataclasses.field(default="")

    def is_leaf(self) -> bool:
        return self.leaf.lower().strip() in ("1", "t", "true")

    def run_install(self) -> None:
        self._execute(self.install.encode())

    def run_uninstall(self) -> None:
        self._execute(self.uninstall.encode())

    def _execute(self, script: str) -> None:
        script = script.strip()
        if not script:
            return

        with tempfile.NamedTemporaryFile() as tmpfile:
            tmpfile.write(script)
            tmpfile.flush()
            os.chmod(tmpfile.name, 0o755)  # noqa: PTH101, S103
            LOG.debug("Execute %s", tmpfile.name)

            subprocess.run(  # noqa: S603
                [tmpfile.name],
                stdin=subprocess.DEVNULL,
                check=True,
                timeout=10,
            )

    @classmethod
    def scan(cls, path: pathlib.Path) -> Config:
        conf = {fld.name: "" for fld in dataclasses.fields(cls)}

        for name in list(conf):
            if (pth := path / MODULE_CONFIG_NAME / name).is_file():
                conf[name] = pth.read_text().strip()

        return cls(**conf)

    def digest(self) -> bytes:
        hasher = hashlib.blake2b(digest_size=32)

        hasher.update(self.leaf.encode())
        hasher.update(b"\x00")
        hasher.update(self.install.encode())
        hasher.update(b"\x00")
        hasher.update(self.uninstall.encode())
        hasher.update(b"\x00")

        return hasher.digest()


@dataclasses.dataclass(frozen=True)
class Node:
    name: str = dataclasses.field(default="")
    parent: Node | None = dataclasses.field(default=None)
    config: Config = dataclasses.field(default_factory=Config)
    directory: bool = dataclasses.field(default=True)
    children: list[Node] = dataclasses.field(
        default_factory=list,
        compare=False,
    )

    def __hash__(self) -> int:
        return hash(
            (
                self.name,
                self.parent,
                self.config,
                self.directory,
            )
        )

    @functools.cached_property
    def path(self) -> pathlib.Path:
        if self.parent is None:
            return pathlib.Path()
        return self.parent.path / self.name

    @functools.cached_property
    def checksum(self) -> bytes:
        hasher = hmac.new(self.name.encode(), self.config.digest(), "blake2b")
        hasher.update(b"\x00" if self.directory else b"\x01")

        for node in sorted(self.children, key=lambda x: x.name.lower()):
            hasher.update(node.checksum)
            hasher.update(b"\x00")

        return hasher.digest()

    @property
    def hex_checksum(self) -> str:
        return binascii.hexlify(self.checksum).decode("latin-1")

    def flattify(self) -> set[Node]:
        nodes = [self]
        flat = set()

        while nodes:
            if (node := nodes.pop()) not in flat:
                flat.add(node)
                nodes.extend(node.children)

        return flat

    def diff(self, new_node: Node) -> tuple[set[Node], set[Node]]:
        if self.checksum == new_node.checksum:
            return set(), set()

        if self != new_node:
            return self.flattify(), new_node.flattify()

        old_children = {chld.name: chld for chld in self.children}
        new_children = {chld.name: chld for chld in new_node.children}
        to_add = {
            newn
            for new_name, newn in new_children.items()
            if new_name not in old_children
        }
        to_remove = set()

        for new_name, newn in new_children.items():
            if new_name not in old_children:
                to_add.update(newn.flattify())

        for old_name, old in old_children.items():
            if old_name not in new_children:
                to_remove.update(old.flattify())
                continue

            o_r, o_a = old.diff(new_children[old_name])
            to_remove.update(o_r)
            to_add.update(o_a)

        return to_remove, to_add


class NodeProcessor(metaclass=abc.ABCMeta):
    topo: graphlib.TopologicalSorter

    def __init__(self, nodes: set[Node]) -> None:
        self.topo = graphlib.TopologicalSorter()

        nodes = set(nodes)
        while nodes:
            if (node := nodes.pop()).parent is not None:
                self.add_node(node)

    def process(self) -> None:
        for node in self.topo.static_order():
            self.process_node(node)

    @abc.abstractmethod
    def add_node(self, node: Node) -> None:
        raise NotImplementedError

    @abc.abstractmethod
    def process_node(self, node: Node) -> None:
        raise NotImplementedError


class NodeCreateProcessor(NodeProcessor):
    source_dir: pathlib.Path
    target_dir: pathlib.Path

    def __init__(
        self,
        source_dir: pathlib.Path,
        target_dir: pathlib.Path,
        nodes: set[Node],
    ) -> None:
        self.source_dir = source_dir.absolute()
        self.target_dir = target_dir.absolute()
        super().__init__(nodes)

    def add_node(self, node: Node) -> None:
        self.topo.add(node)
        for child in node.children:
            self.topo.add(child, node)

    def process_node(self, node: Node) -> None:
        LOG.debug("Create node %s", node.path)

        target_path = self.target_dir / node.path
        target_path.parent.mkdir(parents=True, exist_ok=True)

        if node.directory and not node.config.is_leaf():
            target_path.mkdir(exist_ok=True)
            return

        if not target_path.exists(follow_symlinks=False):
            target_path.symlink_to(
                self.source_dir / node.path,
                target_is_directory=node.directory,
            )


class NodeRemoveProcessor(NodeProcessor):
    target_dir: pathlib.Path

    def __init__(
        self,
        target_dir: pathlib.Path,
        nodes: set[Node],
    ) -> None:
        self.target_dir = target_dir.absolute()
        super().__init__(nodes)

    def add_node(self, node: Node) -> None:
        self.topo.add(node, *node.children)

    def process_node(self, node: Node) -> None:
        LOG.debug("Delete node %s", node.path)

        target_path = self.target_dir / node.path
        if node.directory and not node.config.is_leaf():
            with contextlib.suppress(FileNotFoundError):
                target_path.rmdir()
            return

        target_path.unlink(missing_ok=True)


def collect(root: pathlib.Path) -> Node:
    if not root.is_dir() or root.is_symlink():
        raise ValueError(f"{root} is not a module directory")

    def _collect(path: pathlib.Path, parent: Node | None) -> Node:
        node_name = ""
        if isinstance(parent, Node):
            node_name = path.name

        is_symlink = path.is_symlink()
        node = Node(
            name=node_name,
            parent=parent,
            directory=path.is_dir() and not is_symlink,
            config=Config() if is_symlink else Config.scan(path),
        )
        if is_symlink or node.config.is_leaf() or not node.directory:
            return node

        node.children.extend(
            _collect(item, node)
            for item in path.iterdir()
            if item.name != MODULE_CONFIG_NAME
        )

        return node

    return _collect(root, None)


def _absolute_without_resolving(path: pathlib.Path) -> pathlib.Path:
    return pathlib.Path(os.path.abspath(path))  # noqa: PTH100


def _match_discovered_link(
    source_dir: pathlib.Path,
    target_dir: pathlib.Path,
    source_modules: dict[str, pathlib.Path],
    target_path: pathlib.Path,
) -> tuple[str, tuple[str, ...], pathlib.Path] | None:
    if not target_path.is_symlink():
        return None

    source_path = target_path.readlink()
    if not source_path.is_absolute():
        source_path = target_path.parent / source_path
    source_path = _absolute_without_resolving(source_path)

    if not source_path.is_relative_to(source_dir):
        return None

    source_parts = source_path.relative_to(source_dir).parts
    if not source_parts:
        return None

    module_name, *module_parts = source_parts
    if module_name not in source_modules:
        return None

    target_parts = target_path.relative_to(target_dir).parts
    if tuple(module_parts) != target_parts:
        return None

    return module_name, tuple(module_parts), source_path


def discover(
    source_dir: pathlib.Path,
    target_dir: pathlib.Path,
) -> dict[str, Node]:
    source_dir = _absolute_without_resolving(source_dir)
    target_dir = _absolute_without_resolving(target_dir)
    source_modules = {
        item.name: item
        for item in source_dir.iterdir()
        if item.is_dir() and not item.is_symlink()
    }
    modules: dict[str, Node] = {}

    def get_or_create(
        node: Node,
        name: str,
        source_path: pathlib.Path,
        *,
        directory: bool,
    ) -> Node:
        for chld in node.children:
            if chld.name == name:
                return chld

        new_node = Node(
            name=name,
            parent=node,
            config=Config.scan(source_path),
            directory=directory,
        )
        node.children.append(new_node)

        return new_node

    for dp, dirs, files in os.walk(target_dir, followlinks=False):
        path = pathlib.Path(dp)
        for name in itertools.chain(dirs, files):
            target_path = path / name
            matched = _match_discovered_link(
                source_dir,
                target_dir,
                source_modules,
                target_path,
            )
            if matched is None:
                continue
            module_name, module_parts, source_path = matched

            module_path = source_modules[module_name]
            current_node = modules.get(module_name)
            if current_node is None:
                current_node = Node(config=Config.scan(module_path))
                modules[module_name] = current_node
            current_path = module_path

            for idx, part in enumerate(module_parts):
                current_path /= part
                current_node = get_or_create(
                    current_node,
                    part,
                    current_path,
                    directory=(
                        True
                        if idx < len(module_parts) - 1
                        else source_path.is_dir()
                    ),
                )

    return modules
