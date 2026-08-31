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
import signal
import subprocess
import sys
import typing as t

from nineseconds import exceptions


if t.TYPE_CHECKING:
    import collections.abc
    import pathlib

    P = t.ParamSpec("P")


LOG: t.Final[logging.Logger] = logging.getLogger(__name__)
FORWARDED_SIGNALS: t.Final = (
    signal.SIGHUP,
    signal.SIGINT,
    signal.SIGQUIT,
    signal.SIGTERM,
)


def run(
    *cmd: str | pathlib.Path,
    cwd: pathlib.Path | None = None,
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
        try:
            return func(*args, **kwargs)[0]
        except exceptions.CommandError:
            return ""

    return decorator


@contextlib.contextmanager
def run_in_foreground(
    *cmd: str | pathlib.Path,
    cwd: pathlib.Path | None = None,
    env: dict[str, str] | None = None,
    stdout: int | t.TextIO = sys.stdout,
    stderr: int | t.TextIO = sys.stderr,
) -> collections.abc.Generator[subprocess.Popen[bytes]]:
    command = [str(el) for el in cmd]

    if LOG.isEnabledFor(logging.DEBUG):
        LOG.debug("Execute %s", subprocess.list2cmdline(command))

    proc = subprocess.Popen(  # noqa: S603
        command,
        cwd=cwd,
        env={**os.environ, **(env or {})},
        stdin=sys.stdin,
        stdout=stdout,
        stderr=stderr,
        preexec_fn=os.setpgrp,  # noqa: PLW1509
    )
    with proc, redirect_signals(proc.pid):
        yield proc


@contextlib.contextmanager
def redirect_signals(pgid: int) -> collections.abc.Generator[None]:
    def forward(signum: int, _frame: object) -> None:
        with contextlib.suppress(ProcessLookupError):
            os.killpg(pgid, signum)

        _ = signal.signal(signum, signal.SIG_DFL)
        os.kill(os.getpid(), signum)

    handlers = {sig: signal.signal(sig, forward) for sig in FORWARDED_SIGNALS}

    try:
        yield
    finally:
        for sig, handler in handlers.items():
            _ = signal.signal(sig, handler)
