from dataclasses import dataclass
from typing import Callable, Generator, Sequence, TypeVar

Number = int | float
T = TypeVar("T")


def first_then_apply(
    strings: Sequence[str],
    predicate: Callable[[str], bool],
    function: Callable[[str], T],
) -> T | None:
    for x in strings:
        if predicate(x):
            return function(x)
    return None


def powers_generator(*, base: Number, limit: Number) -> Generator[Number, None, None]:
    value: Number = 1
    while value <= limit:
        yield value
        value *= base


def meaningful_line_count(filename: str, /) -> int:
    count = 0
    with open(filename, "r", encoding="utf-8") as f:
        for line in f:
            s = line.lstrip()
            if s == "" or s == "\n":
                continue
            if s.startswith("#"):
                continue
            if s.strip() == "":
                continue
            count += 1
    return count


def say(word: str | None = None, /):
    words: list[str] = []

    def inner(next_word: str | None = None, /):
        nonlocal words
        if next_word is None:
            return " ".join(words)
        words.append(next_word)
        return inner

    if word is None:
        return ""
    words.append(word)
    return inner


@dataclass(frozen=True)
class Quaternion:
    a: Number = 0
    b: Number = 0
    c: Number = 0
    d: Number = 0

    def __add__(self, o: "Quaternion") -> "Quaternion":
        return Quaternion(self.a + o.a, self.b + o.b, self.c + o.c, self.d + o.d)

    def __mul__(self, o: "Quaternion") -> "Quaternion":
        a1, b1, c1, d1 = self.a, self.b, self.c, self.d
        a2, b2, c2, d2 = o.a, o.b, o.c, o.d
        return Quaternion(
            a1 * a2 - b1 * b2 - c1 * c2 - d1 * d2,
            a1 * b2 + b1 * a2 + c1 * d2 - d1 * c2,
            a1 * c2 - b1 * d2 + c1 * a2 + d1 * b2,
            a1 * d2 + b1 * c2 - c1 * b2 + d1 * a2,
        )

    @property
    def coefficients(self) -> tuple[Number, Number, Number, Number]:
        return (float(self.a), float(self.b), float(self.c), float(self.d))

    @property
    def conjugate(self) -> "Quaternion":
        return Quaternion(self.a, -self.b, -self.c, -self.d)

    def __str__(self) -> str:
        parts: list[str] = []
        if self.a != 0:
            parts.append(f"{self.a}")
        for coeff, sym in ((self.b, "i"), (self.c, "j"), (self.d, "k")):
            if coeff == 0:
                continue
            sign = "+" if coeff > 0 else "-"
            mag = abs(coeff)
            term = sym if mag == 1 else f"{mag}{sym}"
            if not parts:
                parts.append(term if coeff > 0 else f"-{term}")
            else:
                parts.append(f"{sign}{term}")
        return "".join(parts) if parts else "0"


