#!/usr/bin/env python3
# MIT License
#
# Copyright (c) 2024 Sergey Arkhipov
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

import argparse
import json
import logging
import os
import pathlib
import typing as t


LOG: t.Final[logging.Logger] = logging.getLogger(__name__)
"""The main logger."""

REPOSITORY_ROOT: t.Final[pathlib.Path] = (
    pathlib.Path(__file__).absolute().parent
)
"""The root to the repository with dotfiles."""

XDG_STATE_HOME: t.Final[pathlib.Path] = pathlib.Path(
    os.getenv("XDG_STATE_HOME")
    or pathlib.Path.home().joinpath(".local", "state")
)
"""State directory in XDG specification."""

STATE_DBPATH: t.Final[pathlib.Path] = XDG_STATE_HOME.joinpath(
    "9dots", "db.json"
)
"""Path to the file with a database."""


class FS:
    changes: dict[pathlib.Path, pathlib.Path | None]

    def __init__(self) -> None:
        self.changes = {}

    def delete(self, target: pathlib.Path, source: pathlib.Path) -> None:
        LOG.debug("Delete %s -> %s", target, source)
        self.resolve(target)

        match self.changes[target]:
            case None:
                return
            case value if value != source:
                raise ValueError(
                    f"{target} points to {value} but {source} is expected"
                )

        self.changes[target] = None

    def add(self, target: pathlib.Path, source: pathlib.Path) -> None:
        LOG.debug("Add %s -> %s", target, source)

        self.resolve(target)

        if self.changes[target] not in {source, None}:
            raise ValueError(
                f"{target} points to {self.changes[target]}, can't use {source}"
            )

        self.changes[target] = source

    def resolve(self, path: pathlib.Path) -> None:
        if path not in self.changes:
            resolved = path.resolve()
            self.changes[path] = resolved if resolved.exists() else None

    def apply(self, root: pathlib.Path, dry_run: bool = False) -> None:
        changes = self.changes.copy()

        for target, source in list(self.changes.items()):
            if (source is None and not target.exists()) or (
                target.exists() and target.resolve() == source
            ):
                del changes[target]

        if dry_run:
            self.printout(changes)
        else:
            self.execute(root, changes)

    def printout(
        self, changes: dict[pathlib.Path, pathlib.Path | None]
    ) -> None:
        for k, v in sorted((k, v) for k, v in changes.items() if v):
            print(f"Link {k} -> {v}")

        for k in sorted(k for k, v in changes.items() if not v):
            print(f"Delete {k}")

    def execute(
        self,
        root: pathlib.Path,
        changes: dict[pathlib.Path, pathlib.Path | None],
    ) -> None:
        for target, source in changes.items():
            if source is None:
                target.unlink()
                target = target.parent
                while target != root and not list(target.iterdir()):
                    target.rmdir()
                    target = target.parent
            else:
                target.parent.mkdir(parents=True, exist_ok=True)
                target.symlink_to(source)

    def update_snapshot(
        self, snapshot: dict[pathlib.Path, pathlib.Path]
    ) -> None:
        for target, source in self.changes.items():
            if source is None:
                snapshot.pop(target, None)
            else:
                snapshot[target] = source


def main() -> None:
    options = get_options()

    logging.basicConfig(
        format="> %(message)s",
        level=logging.DEBUG if options.debug else logging.INFO,
    )
    LOG.debug("Parameters: %s", options)
    STATE_DBPATH.parent.mkdir(parents=True, exist_ok=True)

    snapshot: dict[pathlib.Path, pathlib.Path] = {}
    if STATE_DBPATH.exists():
        snapshot = {
            pathlib.Path(k): pathlib.Path(v)
            for k, v in json.loads(STATE_DBPATH.read_text()).items()
        }

    fs: FS = FS()

    options.action(options, fs, snapshot)
    fs.apply(options.target, options.dry_run)

    if not options.dry_run:
        fs.update_snapshot(snapshot)
        STATE_DBPATH.write_text(
            json.dumps(
                {str(k): str(v) for k, v in snapshot.items()},
                sort_keys=True,
                indent=2,
            )
        )


def get_options() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Manage dotfiles for this repository.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )

    def path_type(value: str) -> pathlib.Path:
        pth = pathlib.Path(value).expanduser().absolute()
        try:
            pth.relative_to(REPOSITORY_ROOT)
        except ValueError as exc:
            raise argparse.ArgumentTypeError(str(exc)) from exc

        if pth.parent != REPOSITORY_ROOT:
            raise argparse.ArgumentTypeError(
                f"{value} should be a top level directory"
            )

        return dir_type(str(pth))

    def dir_type(value: str) -> pathlib.Path:
        pth = pathlib.Path(value).expanduser().absolute()
        if not pth.is_dir():
            raise argparse.ArgumentTypeError(f"{value} should be a directory")

        return pth

    parser.add_argument(
        "-d",
        "--debug",
        action="store_true",
        default=False,
        help="Run in debug mode",
    )
    parser.add_argument(
        "-t",
        "--target",
        default=str(pathlib.Path.home()),
        type=dir_type,
        help="Directory to farm links into",
    )
    parser.add_argument(
        "-n", "--dry-run", action="store_true", default=False, help="Dry run"
    )

    subparsers = parser.add_subparsers(title="Subcommands")

    plug_parser = subparsers.add_parser(
        "plug", help="Plug a subdirectory into target"
    )
    plug_parser.add_argument(
        "module",
        type=path_type,
        nargs=argparse.ONE_OR_MORE,
        help="Module directory to use",
    )
    plug_parser.set_defaults(action=action_plug)

    unplug_parser = subparsers.add_parser(
        "unplug", help="Unplug directory from target"
    )
    unplug_parser.add_argument(
        "module",
        type=path_type,
        nargs=argparse.ONE_OR_MORE,
        help="Module directory to use",
    )
    unplug_parser.set_defaults(action=action_unplug)

    return parser.parse_args()


def action_plug(
    options: argparse.Namespace,
    fs: FS,
    snapshot: dict[pathlib.Path, pathlib.Path],
) -> None:
    action_unplug(options, fs, snapshot)

    for module in options.module:
        for dirpath, _, filenames in module.walk():
            target_dir = options.target.joinpath(
                str(dirpath)[len(str(module)) + 1 :]
            )
            for filename in filenames:
                fs.add(target_dir / filename, dirpath / filename)


def action_unplug(
    options: argparse.Namespace,
    fs: FS,
    snapshot: dict[pathlib.Path, pathlib.Path],
) -> None:
    to_filter = tuple(f"{path}/" for path in options.module)

    for target, source in snapshot.items():
        if str(source).startswith(to_filter):
            fs.delete(target, source)


if __name__ == "__main__":
    main()