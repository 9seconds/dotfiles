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

import logging
import typing as t

from nineseconds import env


class LogFormatter(logging.Formatter):
    DEFAULT_PREFIX: t.ClassVar[str] = ">  "
    PREFIXES: t.ClassVar[t.Mapping[int, str]] = {
        logging.DEBUG: ">>>",
        logging.WARNING: "!  ",
        logging.ERROR: "!!!",
        logging.CRITICAL: "!!!"
    }

    def format(self, record: logging.LogRecord) -> str:
        prefix = self.PREFIXES.get(record.levelno, self.DEFAULT_PREFIX)
        return f"{prefix} {super().format(record)}"


def configure(*, debug: bool = env.debug()) -> None:
    root = logging.getLogger()

    for handler in root.handlers[:]:
        root.removeHandler(handler)
        handler.close()

    log_handler = logging.StreamHandler()
    log_handler.setFormatter(LogFormatter())

    root.addHandler(log_handler)
    root.setLevel(logging.DEBUG if debug else logging.ERROR)
