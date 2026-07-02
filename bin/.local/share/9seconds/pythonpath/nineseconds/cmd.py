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

import contextlib
import functools
import logging
import os
import subprocess
import typing as t

from nineseconds import exceptions


if t.TYPE_CHECKING:
    import pathlib

    P = t.ParamSpec("P")


LOG: t.Final[logging.Logger] = logging.getLogger(__name__)


def run(
    *cmd: str | pathlib.Path,
    cwd: None | pathlib.Path = None,
    env: dict[str, str] | None = None,
) -> list[str]:
    command = [str(el) for el in cmd]

    if LOG.isEnabledFor(logging.DEBUG):
        LOG.debug("Execute %s", subprocess.list2cmdline(command))

    result = subprocess.run(  # noqa: S603
        command,
        stdin=subprocess.DEVNULL,
        check=False,
        capture_output=True,
        text=True,
        cwd=cwd,
        env={**os.environ, **(env or {})},
    )

    LOG.debug("  Exit code: %d", result.returncode)

    stdout = result.stdout.splitlines()
    for line in stdout:
        LOG.debug("  Stdout: %s", line)

    stderr = result.stderr.splitlines()
    for line in stderr:
        LOG.debug("  Stderr: %s", line)

    if result.returncode:
        raise exceptions.CommandError(
            cmd=command,
            stderr=stderr,
            exit_code=result.returncode,
        )

    return stdout


def first_or_empty_string(func: t.Callable[P, list[str]]) -> t.Callable[P, str]:
    @functools.wraps(func)
    def decorator(*args: P.args, **kwargs: P.kwargs) -> str:
        with contextlib.suppress(exceptions.CommandError):
            return func(*args, **kwargs)[0]
        return ""

    return decorator
