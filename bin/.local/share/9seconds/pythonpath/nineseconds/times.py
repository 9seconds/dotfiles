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

import datetime


def now() -> datetime.datetime:
    return datetime.datetime.now(tz=datetime.timezone.utc)


def elapsed(total_seconds: float) -> str:
    rem, msecs = divmod(total_seconds, 1.0)
    rem, seconds = divmod(rem, 60.0)
    rem, minutes = divmod(rem, 60.0)
    rem, hours = divmod(rem, 60.0)
    weeks, days = divmod(rem, 24.0)

    chunks: list[str] = []
    if v := int(weeks):
        chunks.append(f"{v} weeks")
    if v := int(days):
        chunks.append(f"{v} days")
    if v := int(hours):
        chunks.append(f"{v} hours")
    if v := int(minutes):
        chunks.append(f"{v} minutes")
    if v := int(seconds):
        chunks.append(f"{v} seconds")
    if not chunks:
        chunks.append(f"{round(msecs * 1000.0)} milliseconds")

    return ", ".join(chunks)
