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

import re
import shlex
import typing as t
import unicodedata


if t.TYPE_CHECKING:
    import collections.abc


def slugify(value: str, delimiter: str = "_") -> str:
    value = "".join(
        ch if (unicodedata.category(ch)[0] in ("L", "N")) else delimiter
        for ch in unicodedata.normalize("NFKC", value).lower()
    )
    value = re.sub(f"{re.escape(delimiter)}{2,}", delimiter, value)

    return value.strip(delimiter)


def print_rows(
    rows: collections.abc.Sequence[collections.abc.Sequence[str]],
    *,
    is_shlex: bool = False
) -> None:
    if not rows:
        return

    stringify = str
    if is_shlex:
        stringify = lambda el: shlex.quote(str(el))  # noqa: E731

    rows = [[stringify(r) for r in row] for row in rows]
    lengths = [0] * len(rows[0])

    for row in rows:
        for idx, col in enumerate(row):
            lengths[idx] = max(len(col), lengths[idx])

    for row in rows:
        values = (
            col.ljust(length) for length, col in zip(lengths, row, strict=True)
        )
        print("\t".join(values))  # noqa: T201
