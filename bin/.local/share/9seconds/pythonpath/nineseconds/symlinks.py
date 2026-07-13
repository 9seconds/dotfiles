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

import configparser
import functools
import logging
import os
import pathlib
import tempfile
import textwrap
import typing as t

from nineseconds import cache
from nineseconds import cmd


LOG: t.Final = logging.getLogger(__name__)
CONFIG_NAME: t.Final = ".___9s.ini"


class Hooks:
    target_dir: pathlib.Path
    scripts: list[tuple[pathlib.Path, str]]

    def __init__(self, target_dir: pathlib.Path) -> None:
        self.target_dir = target_dir
        self.scripts = []

    def add(self, directory: pathlib.Path, hook: str) -> None:
        hook = textwrap.dedent(hook)
        if not hook:
            return

        if not hook.startswith("#!"):
            hook = f"#!/usr/bin/env bash\nset -eu -o pipefail\n{hook}"

        self.scripts.append((directory, hook))

    def apply(self) -> None:
        for directory, hook in reversed(self.scripts):
            with tempfile.NamedTemporaryFile(mode="wt", delete=False) as tmp:
                tmp.write(hook)

            path = pathlib.Path(tmp.name)
            path.chmod(0o755)

            try:
                cmd.run(
                    tmp.name,
                    cwd=directory,
                    env={
                        "USER_CWD": os.fspath(pathlib.Path.cwd()),
                        "TARGET_DIR": os.fspath(self.target_dir),
                    },
                )
            finally:
                path.unlink()

            LOG.info("Executed hook for %s", directory)


def mount(
    source_dir: pathlib.Path,
    target_dir: pathlib.Path,
) -> list[pathlib.Path]:
    source_dir = source_dir.absolute()
    target_dir = target_dir.absolute()

    hooks = Hooks(target_dir)
    make_symlink = functools.partial(
        _mount_make_symlink,
        source_dir,
        target_dir,
    )

    mounted: list[pathlib.Path] = []

    for dirpath_, dirnames, filenames in os.walk(source_dir):
        dirpath = pathlib.Path(dirpath_).absolute()
        parser = configparser.ConfigParser()
        if CONFIG_NAME in filenames:
            parser.read(dirpath / CONFIG_NAME)
            filenames.remove(CONFIG_NAME)

        hooks.add(
            dirpath, parser.get(parser.default_section, "hook", fallback="")
        )

        match parser.get(parser.default_section, "type", fallback="granular"):
            case "granular":
                mounted.extend(
                    make_symlink(dirpath / filename) for filename in filenames
                )
            case "leaf":
                dirnames.clear()
                mounted.append(make_symlink(dirpath))
            case value:
                raise RuntimeError(f"Unknown dir type {value}")

    hooks.apply()

    return mounted


def mount_cached(
    cache_: cache.Cache, source_dir: pathlib.Path, target_dir: pathlib.Path
) -> list[pathlib.Path]:
    result = mount(source_dir, target_dir)
    key = cache_key(source_dir, target_dir)
    cache_[key] = result

    return result


def _mount_make_symlink(
    source_dir: pathlib.Path,
    target_dir: pathlib.Path,
    source_path: pathlib.Path,
) -> pathlib.Path:
    target_file = target_dir / source_path.relative_to(source_dir)
    target_file.parent.mkdir(exist_ok=True, parents=True)
    target_file.symlink_to(
        source_path, target_is_directory=source_path.is_dir()
    )
    LOG.info("Symlinked %s -> %s", target_file, source_path)

    return target_file


def _unmount_scan(
    source_dir: pathlib.Path,
    target_dir: pathlib.Path,
) -> list[pathlib.Path]:
    found: list[pathlib.Path] = []

    def is_ok(path: pathlib.Path) -> bool:
        if not path.is_symlink():
            return False
        return path.readlink().is_relative_to(source_dir)

    if is_ok(target_dir):
        return [target_dir]

    for dirpath_, _, filenames in os.walk(target_dir.absolute()):
        dirpath = pathlib.Path(dirpath_)
        found.extend(
            path for filename in filenames if is_ok(path := dirpath / filename)
        )

    found.sort(reverse=True)

    return found


def _unmount(
    source_dir: pathlib.Path,
    target_dir: pathlib.Path,
    *,
    _scan: t.Callable[
        [pathlib.Path, pathlib.Path], list[pathlib.Path]
    ] = _unmount_scan,
) -> list[pathlib.Path]:
    source_dir = source_dir.absolute()
    target_dir = target_dir.absolute()

    to_delete = _scan(source_dir, target_dir)

    for filename in to_delete:
        filename.unlink()
        LOG.info("Deleted %s", filename)

        parent = filename
        while (parent := parent.parent).is_relative_to(target_dir):
            if next(parent.iterdir(), None) is None:
                parent.rmdir()
                LOG.info("Deleted empty %s", parent)

    return to_delete


def unmount(
    source_dir: pathlib.Path,
    target_dir: pathlib.Path,
) -> list[pathlib.Path]:
    return _unmount(source_dir, target_dir, _scan=_unmount_scan)


def unmount_cached(
    cache_: cache.Cache,
    source_dir: pathlib.Path,
    target_dir: pathlib.Path,
) -> list[pathlib.Path]:
    def scan(
        source_dir: pathlib.Path, target_dir: pathlib.Path
    ) -> list[pathlib.Path]:
        key = cache_key(source_dir, target_dir)
        if key in cache_:
            return cache_[key]
        return _unmount_scan(source_dir, target_dir)

    return _unmount(source_dir, target_dir, _scan=scan)


def cache_key(source_dir: pathlib.Path, target_dir: pathlib.Path) -> str:
    return cache.cache_key([os.fspath(source_dir), os.fspath(target_dir)])
