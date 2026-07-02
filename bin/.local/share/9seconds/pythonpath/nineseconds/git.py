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
def get_dir() -> pathlib.Path:
    if value := os.getenv("GIT_DIR"):
        path = value
    else:
        path = run("rev-parse", "--absolute-git-dir", set_git_dir=False)[0]

    return pathlib.Path(path).absolute()


@functools.cache
def get_common_dir() -> pathlib.Path:
    path = run("rev-parse", "--git-common-dir")[0]
    return pathlib.Path(path).absolute()


@functools.cache
@cmd.first_or_empty_string
def get_current_branch() -> list[str]:
    return run("symbolic-ref", "--short", "--quiet", "HEAD")


@functools.cache
@cmd.first_or_empty_string
def config_get(setting: str) -> list[str]:
    return run("config", "get", setting)


def config_set(key: str, value: str, *, local: bool = True) -> None:
    command = ["config", "set"]
    if local:
        command.append("--local")

    run(*command, key, value)


def run(*args: str | pathlib.Path, set_git_dir: bool = True) -> list[str]:
    command = [
        get_bin(),
        "-P",
        "--no-advice",
    ]
    if set_git_dir:
        command.append("--git-dir")
        command.append(get_dir())

    command.extend(args)

    return cmd.run(
        *command,
        env={"NO_COLOR": "1", "TZ": "UTC"},
    )
