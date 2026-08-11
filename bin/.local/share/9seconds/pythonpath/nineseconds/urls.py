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

import copy
import pathlib
import urllib.parse


class URL:
    scheme: str
    host: str
    username: str | None
    password: str | None
    port: int | None
    path: pathlib.Path
    query: dict[str, list[str]]

    def __init__(self, url: str) -> None:
        split = urllib.parse.urlsplit(url, scheme="file")

        self.scheme = split.scheme
        self.host = split.hostname or ""
        self.port = split.port
        self.username = split.username
        self.password = split.password
        self.path = pathlib.PosixPath("/").joinpath(split.path)
        self.query = urllib.parse.parse_qs(split.query)

    def copy(self) -> URL:
        return copy.deepcopy(self)

    @property
    def netloc(self) -> str:
        rv = self.host
        if self.port is not None:
            rv = f"{rv}:{self.port}"

        if self.username is None and self.password is None:
            return rv

        return f"{self.username or ''}:{self.password or ''}@{rv}"

    def url(self) -> str:
        return urllib.parse.urlunsplit(
            (
                self.scheme,
                self.netloc,
                str(self.path),
                urllib.parse.urlencode(self.query, doseq=True),
                None,
            ),
        )
