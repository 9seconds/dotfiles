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

import argparse
import functools
import logging as log
import os
import pathlib
import sys
import typing as t

from nineseconds import env
from nineseconds import exceptions
from nineseconds import logging


if t.TYPE_CHECKING:

    class EnvArgumentT(t.TypedDict):
        help: str
        default: str

    class EnvBoolArgumentT(t.TypedDict):
        help: str
        action: str
        default: bool


LOG: t.Final[log.Logger] = log.getLogger(__name__)


def main(func: t.Callable[[], argparse.ArgumentParser]) -> t.Callable[[], None]:
    @functools.wraps(func)
    def decorator() -> None:
        logging.configure()

        parser = func()
        parser.set_defaults(cmd=lambda _: parser.print_help())
        parser.add_argument(
            "-x",
            "--shlex",
            action="store_true",
            help="print columns parseable by shell lexers",
        )
        parser.add_argument(
            "-d",
            "--debug",
            **env_bool_argument(
                "run in debug mode",
                env.DEBUG,
                env.debug,
            ),
        )

        options = parser.parse_args()
        logging.configure(debug=options.debug)

        LOG.info("Options: %s", options)

        try:
            options.cmd(options)
        except exceptions.CommandError as exc:
            for line in exc.stderr:
                print(line, file=sys.stderr)  # noqa: T201
            sys.exit(exc.exit_code)

    return decorator


def env_argument(
    msg: str,
    name: str,
    value_getter: t.Callable[[], str | None],
) -> EnvArgumentT:
    value = os.getenv(name, None)
    return {
        "help": f"{msg} [env: {name}]",
        "default": value if value is not None else value_getter(),
    }


def env_bool_argument(
    msg: str,
    name: str,
    value_getter: t.Callable[[], bool | None],
) -> EnvBoolArgumentT:
    if (val := os.environ.get(name)) is not None:
        value = env.as_bool(val)
    else:
        value = value_getter()

    return {
        "help": f"{msg} [env: {name}]",
        "action": "store_true",
        "default": value,
    }


def type_non_negative_int(value: str) -> int:
    try:
        converted = int(value)
    except ValueError as exc:
        raise argparse.ArgumentTypeError("not a positive int") from exc

    if converted < 0:
        raise argparse.ArgumentTypeError("not a positive int")

    return converted


def type_valid_dir(value: str) -> pathlib.Path:
    if (path := pathlib.Path(value)).is_dir():
        return path
    raise argparse.ArgumentTypeError("not a directory")
