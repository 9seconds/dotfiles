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

import collections.abc
import gzip
import hashlib
import logging
import pickle
import struct
import typing as t

from nineseconds import paths


if t.TYPE_CHECKING:
    import pathlib

    P = t.ParamSpec("P")

    KeyT = (
        list["KeyT"]
        | tuple["KeyT", ...]
        | set["KeyT"]
        | frozenset["KeyT"]
        | dict["KeyT", "KeyT"]
        | bool
        | int
        | float
        | str
        | bytes
        | bytearray
        | None
    )

    class HasLenT(t.Protocol):
        def __len__(self) -> int: ...


LOG: t.Final = logging.getLogger(__name__)
T = t.TypeVar("T")


class Cache(collections.abc.MutableMapping[str, T]):
    data_dir: pathlib.Path

    def __init__(self, app: str) -> None:
        self.data_dir = paths.cache(app)

    def __setitem__(self, key: str, value: T) -> None:
        if key in self:
            LOG.warning("Key %s already exists. Overwrite", key)

        self.data_dir.mkdir(exist_ok=True, parents=True)
        with gzip.open(self.data_dir / key, mode="wb") as gfp:
            pickle.dump(value, gfp)
        LOG.debug("Set cache %s", key)

    def __getitem__(self, key: str, /) -> T:
        try:
            with gzip.open(self.data_dir / key) as gfp:
                return t.cast("T", pickle.load(gfp))
        except FileNotFoundError as exc:
            raise KeyError("Cannot find a file") from exc

    def __delitem__(self, key: str) -> None:
        try:
            self.data_dir.joinpath(key).unlink()
        except Exception as exc:
            raise KeyError("Cannot delete") from exc
        LOG.debug("Deleted cache %s", key)

    def __iter__(self) -> t.Generator[str]:
        for pth in self.data_dir.iterdir():
            yield pth.name

    def __len__(self) -> int:
        return sum(1 for _ in self.data_dir.iterdir())

    def __contains__(self, key: object) -> bool:
        if not isinstance(key, str):
            return False
        return self.data_dir.joinpath(key).exists()


def cache_key(value: KeyT) -> str:
    hasher = hashlib.blake2b(digest_size=32)

    for item in _produce_key(value):
        hasher.update(item)

    return hasher.hexdigest()


def _produce_key(value: KeyT) -> t.Generator[bytes]:  # noqa: PLR0912, C901
    match value:
        case list() | tuple():
            yield (b"L" if isinstance(value, list) else b"T")
            yield _produce_len(value)
            for el in value:
                yield from _produce_key(el)

        case dict():
            yield b"D"
            yield _produce_len(value)
            for k, v in sorted(value.items()):
                yield from _produce_key(k)
                yield from _produce_key(v)

        case set() | frozenset():
            yield (b"S" if isinstance(value, set) else b"F")
            yield _produce_len(value)
            for el in sorted(value):
                yield from _produce_key(el)

        case None:
            yield b"N"

        case bool():
            yield b"B"
            yield (b"1" if value else b"0")

        case int():
            yield b"I"
            yield value.to_bytes(8, byteorder="little")

        case float():
            yield b"L"
            yield struct.pack("@d", value)

        case str():
            yield b"S"
            enc = value.encode()
            yield _produce_len(enc)
            yield enc

        case bytes():
            yield b"B"
            yield _produce_len(value)
            yield value

        case bytearray():
            yield from _produce_key(bytes(value))

        case _:
            raise TypeError(f"Unexpected type {type(value)}")


def _produce_len(value: HasLenT) -> bytes:
    return len(value).to_bytes(8, byteorder="little")
