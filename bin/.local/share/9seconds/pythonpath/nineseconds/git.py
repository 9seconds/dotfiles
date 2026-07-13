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

import functools
import os
import pathlib
import shutil

from nineseconds import cmd
from nineseconds import exceptions


@functools.cache
def get_bin() -> pathlib.Path:
    if value := os.getenv("GIT_EXEC_PATH"):
        path = pathlib.Path(value) / "git"
    else:
        path = shutil.which("git") or ""

    if shutil.which(path) is None:
        raise OSError(f"Cannot detect git binary: {path}")

    return pathlib.Path(path).absolute()


@functools.cache
def get_dir(*, cwd: pathlib.Path | None = None) -> pathlib.Path:
    if value := os.getenv("GIT_DIR"):
        path = value
    else:
        path = run(
            "rev-parse", "--absolute-git-dir", cwd=cwd, set_git_dir=False
        )[0]

    return pathlib.Path(path).absolute()


@functools.cache
def get_common_dir(*, cwd: pathlib.Path | None = None) -> pathlib.Path:
    path = run("rev-parse", "--git-common-dir", cwd=cwd)[0]
    return pathlib.Path(path).absolute()


@functools.cache
@cmd.first_or_empty_string
def get_current_branch(*, cwd: pathlib.Path | None = None) -> list[str]:
    return run("symbolic-ref", "--short", "--quiet", "HEAD", cwd=cwd)


@functools.cache
@cmd.first_or_empty_string
def config_get(setting: str, *, cwd: pathlib.Path | None = None) -> list[str]:
    return run("config", "get", setting, cwd=cwd)


def config_set(
    key: str, value: str, *, cwd: pathlib.Path | None = None, local: bool = True
) -> None:
    command = ["config", "set"]
    if local:
        command.append("--local")

    run(*command, key, value, cwd=cwd)


@functools.cache
def is_inside_git_worktree(*, cwd: pathlib.Path) -> bool:
    try:
        run("rev-parse", "--is-inside-work-tree", cwd=cwd)
    except exceptions.CommandError:
        return False
    return True


def run(
    *args: str | pathlib.Path,
    cwd: pathlib.Path | None = None,
    set_git_dir: bool = True,
) -> list[str]:
    command = [
        get_bin(),
        "-P",
        "--no-advice",
    ]
    if set_git_dir:
        command.append("--git-dir")
        command.append(get_dir(cwd=cwd))

    command.extend(args)

    return cmd.run(
        *command,
        cwd=cwd,
        env={"NO_COLOR": "1", "TZ": "UTC"},
    )
