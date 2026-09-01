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

import base64
import contextlib
import copy
import gzip
import json
import logging
import pathlib
import typing as t
import urllib.error
import urllib.parse
import urllib.request


LOG: t.Final = logging.getLogger(__name__)


class URL:
    scheme: str
    host: str
    username: str | None
    password: str | None
    port: int | None
    fragment: str | None
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
        self.fragment = split.fragment

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


class Request:
    _headers: dict[str, str]
    _method: str
    _url: str
    _data: bytes

    def __init__(self, url: str | URL) -> None:
        self._url = url.url() if isinstance(url, URL) else url
        self._headers = {}
        self._method = ""
        self._data = b""

    def header(self, name: str, value: str) -> Request:
        self._headers[name.lower()] = value
        return self

    def method(self, method: str) -> Request:
        self._method = method
        return self

    def basic_auth(self, user: str, password: str) -> Request:
        encoded = base64.standard_b64encode(f"{user}:{password}".encode())
        self._headers["authorization"] = f"Basic {encoded.decode()}"
        return self

    def body(
        self, data: str | bytes, *, content_type: str | None = None
    ) -> Request:
        self._headers.pop("content-type", None)
        self._data = data if isinstance(data, bytes) else data.encode()
        if content_type is not None:
            self._headers["content-type"] = content_type
        return self

    def json(self, data: object) -> Request:
        return self.body(
            json.dumps(data).encode(),
            content_type="application/json",
        )

    def do(self, *, raise_if_error: bool = True) -> tuple[bytes, int]:
        method = self._method
        if not method:
            method = "GET" if not self._data else "POST"

        headers = self._headers.copy()
        headers.setdefault("accept-encoding", "gzip")

        req = urllib.request.Request(  # noqa: S310
            url=self._url,
            method=method,
            headers=headers,
            data=self._data or None,
        )

        try:
            resp = urllib.request.urlopen(req)  # noqa: S310
        except urllib.error.HTTPError as exc:
            LOG.error("Got %d %s", exc.code, exc.reason)
            if not raise_if_error:
                return self._read_response_body(exc), exc.code
            raise

        return self._read_response_body(resp), resp.status

    @classmethod
    def _read_response_body(cls, resp: urllib.request.addinfourl) -> bytes:
        with contextlib.closing(resp):
            fp = resp
            if resp.headers.get("content-encoding") == "gzip":
                fp = gzip.GzipFile(fileobj=resp)
            return fp.read()
