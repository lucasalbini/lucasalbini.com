"""In-memory per-IP rate limiter. Good enough for a single-instance FastAPI.

If we scale horizontally, swap this for Redis; the interface stays the same.
"""

from __future__ import annotations

import time
from collections import defaultdict


class RateLimiter:
    def __init__(self, max_per_hour: int) -> None:
        self.max = max_per_hour
        self.window = 3600
        self._hits: dict[str, list[float]] = defaultdict(list)

    def check(self, key: str) -> bool:
        now = time.time()
        cutoff = now - self.window
        hits = [t for t in self._hits[key] if t >= cutoff]
        self._hits[key] = hits
        if len(hits) >= self.max:
            return False
        hits.append(now)
        return True
