import fs from "fs";

export function firstThenApply(strings, predicate, fn) {
  const hit = Array.isArray(strings)
    ? strings.find((s) => (predicate ? predicate(s) : false))
    : undefined;

  return hit !== undefined ? (fn ? fn(hit) : undefined) : undefined;
}

export function* powersGenerator({ ofBase: base, upTo: limit }) {
  let v = 1;
  while (v <= limit) {
    yield v;
    v *= base;
  }
}

export function meaningfulLineCount(filename) {
  const text = fs.readFileSync(filename, "utf8");
  return text
    .split(/\r?\n/)
    .filter((line) => {
      const s = line.replace(/^\s+/, "");
      if (s === "" || /^\s*$/.test(line)) return false;
      if (s.startsWith("#")) return false;
      return true;
    }).length;
}

export function say(word) {
  const words = [];
  if (word === undefined) return "";
  words.push(word);

  function inner(...nextArgs) {
    if (nextArgs.length === 0) {
      return words.join(" ");
    }
    const [next] = nextArgs;
    words.push(next);
    return inner;
  }

  return inner;
}

export class Quaternion {
  constructor(a = 0, b = 0, c = 0, d = 0) {
    this.a = +a;
    this.b = +b;
    this.c = +c;
    this.d = +d;
    Object.freeze(this);
  }

  plus(o) {
    return new Quaternion(
      this.a + o.a,
      this.b + o.b,
      this.c + o.c,
      this.d + o.d
    );
  }

  times(o) {
    const { a: a1, b: b1, c: c1, d: d1 } = this;
    const { a: a2, b: b2, c: c2, d: d2 } = o;
    return new Quaternion(
      a1 * a2 - b1 * b2 - c1 * c2 - d1 * d2,
      a1 * b2 + b1 * a2 + c1 * d2 - d1 * c2,
      a1 * c2 - b1 * d2 + c1 * a2 + d1 * b2,
      a1 * d2 + b1 * c2 - c1 * b2 + d1 * a2
    );
  }

  get coefficients() {
    return [this.a, this.b, this.c, this.d];
  }

  get conjugate() {
    return new Quaternion(this.a, -this.b, -this.c, -this.d);
  }

  equals(o) {
    return (
      this.a === o.a &&
      this.b === o.b &&
      this.c === o.c &&
      this.d === o.d
    );
  }

  toString() {
    const parts = [];
    if (this.a !== 0) parts.push(`${this.a}`);

    const add = (c, s) => {
      if (c === 0) return;
      const sign = c > 0 ? "+" : "-";
      const mag = Math.abs(c);
      const term = mag === 1 ? s : `${mag}${s}`;
      if (!parts.length) {
        parts.push(c > 0 ? term : `-${term}`);
      } else {
        parts.push(`${sign}${term}`);
      }
    };

    add(this.b, "i");
    add(this.c, "j");
    add(this.d, "k");

    return parts.length ? parts.join("") : "0";
  }
}
