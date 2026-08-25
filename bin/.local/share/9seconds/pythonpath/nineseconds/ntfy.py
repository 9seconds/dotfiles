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
import gzip
import hashlib
import json
import logging
import pathlib
import secrets
import subprocess
import typing as t
import urllib.error
import urllib.request

from nineseconds import cli


if t.TYPE_CHECKING:
    import argparse


LOG: t.Final = logging.getLogger(__name__)

DEFAULT_SERVER: t.Final = "http://ntfy.sh"
DEFAULT_PRIORITY: t.Final[int] = 3
PATH_MACHINE_ID: t.Final = pathlib.Path("/etc/machine-id")


class Ntfy:
    _server: str
    _topic: str
    _user: str

    def __init__(
        self,
        server: str | None,
        topic: str | None,
        user: str | None,
    ) -> None:
        self._server = server or DEFAULT_SERVER
        self._topic = topic or get_default_topic()
        self._user = user or ""

    def send(
        self,
        title: str,
        message: str,
        *,
        tags: list[str] | None = None,
        priority: int = DEFAULT_PRIORITY,
        actions: list[dict] | None = None,
        sequence_id: str = "",
    ) -> str:
        headers = {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Accept-Encoding": "gzip",
        }
        if sequence_id:
            headers["X-Sequence-ID"] = sequence_id

        if self._user:
            if ":" in self._user:
                encoded = base64.standard_b64encode(self._user.encode())
                headers["Authorization"] = f"Basic {encoded.decode()}"
            else:
                headers["Authorization"] = f"Bearer {self._user}"

        req = urllib.request.Request(
            url=self._server,
            method="POST",
            headers=headers,
            data=json.dumps(
                {
                    "topic": self._topic,
                    "title": title,
                    "message": message,
                    "tags": tags or [],
                    "actions": actions or [],
                    "priority": priority,
                },
            ).encode(),
        )

        LOG.debug("Send to %s", self._topic)

        try:
            resp = urllib.request.urlopen(req)
        except urllib.error.HTTPError as exc:
            LOG.error("Got %d %s", exc.code, exc.reason)
            with contextlib.closing(exc.file) as fp:
                LOG.error("Error body: %s", fp.read().decode())
            raise

        with contextlib.closing(resp):
            fp = resp
            if resp.headers.get("Content-Encoding") == "gzip":
                fp = gzip.GzipFile(fileobj=resp)
            data = json.load(fp)

        return data["sequence_id"]

    @classmethod
    def from_options(cls, options: argparse.Namespace) -> Ntfy:
        return Ntfy(options.ntfy_url, options.ntfy_topic, options.ntfy_user)


class Updater:
    _instance: Ntfy
    _title: str
    _tags: list[str]
    _priority: int
    _actions: list[dict]
    _sequence_id: str

    def __init__(
        self,
        instance: Ntfy,
        title: str,
        *,
        tags: list[str] | None = None,
        priority: int = DEFAULT_PRIORITY,
        actions: list[dict] | None = None,
    ) -> None:
        self._instance = instance
        self._title = title
        self._tags = tags or []
        self._priority = priority
        self._actions = actions or []
        self._sequence_id = secrets.token_urlsafe()

    def send(
        self,
        message: str,
        *,
        title: str | None = None,
        tags: list[str] | None = None,
        priority: int | None = None,
        actions: list[dict] | None = None,
    ) -> None:
        self._instance.send(
            title=self._title if title is None else title,
            message=message,
            tags=self._tags + (tags or []),
            priority=self._priority if priority is None else priority,
            actions=self._actions + (actions or []),
            sequence_id=self._sequence_id,
        )


def add_parser_options(parser: argparse.ArgumentParser) -> None:
    parser.add_argument(
        "--ntfy-url",
        type=str,
        **cli.env_argument(
            "ntfy server url",
            "NTFY_SERVER",
            lambda: DEFAULT_SERVER,
        ),
    )
    parser.add_argument(
        "--ntfy-user",
        type=str,
        **cli.env_argument("ntfy user", "NTFY_USER", lambda: None),
    )
    parser.add_argument(
        "--ntfy-topic",
        type=str,
        **cli.env_argument("ntfy topic", "NTFY_TOPIC", get_default_topic),
    )


def get_default_topic() -> str:
    if PATH_MACHINE_ID.exists():
        value = PATH_MACHINE_ID.read_bytes()
    else:
        value = subprocess.check_output(
            ["ioreg", "-d2", "-c", "IOPlatformExpertDevice"],
            text=False,
        )

    hashed = hashlib.sha1(value).digest()
    return base64.b32hexencode(hashed).lower().decode()
