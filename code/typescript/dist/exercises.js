export function firstThenApply(as, p, f) {
    const found = as.find(p);
    return found === undefined ? undefined : f(found);
}
export function* powersGenerator(base) {
    let current = 1n;
    while (true) {
        yield current;
        current *= base;
    }
}
import * as fs from "node:fs";
import * as readline from "node:readline";
export async function meaningfulLineCount(filePath) {
    const stream = fs.createReadStream(filePath, { encoding: "utf8" });
    const rl = readline.createInterface({ input: stream, crlfDelay: Infinity });
    let count = 0;
    try {
        for await (const raw of rl) {
            const line = String(raw).trim();
            if (line.length === 0)
                continue;
            if (line.startsWith("#"))
                continue;
            count += 1;
        }
        return count;
    }
    finally {
        rl.close();
    }
}
export function surfaceArea(s) {
    switch (s.kind) {
        case "Sphere":
            return 4 * Math.PI * s.radius * s.radius;
        case "Box":
            return 2 * (s.width * s.length + s.width * s.depth + s.length * s.depth);
    }
}
export function volume(s) {
    switch (s.kind) {
        case "Sphere":
            return (4 / 3) * Math.PI * s.radius * s.radius * s.radius;
        case "Box":
            return s.width * s.length * s.depth;
    }
}
function cmp(a, b) {
    return a < b ? -1 : a > b ? 1 : 0;
}
export class BinarySearchTree {
}
export class Empty extends BinarySearchTree {
    size() { return 0; }
    contains(_value) { return false; }
    insert(value) { return new Node(value, this, this); }
    *inorder() { }
    toString() { return "()"; }
}
class Node extends BinarySearchTree {
    value;
    left;
    right;
    _size;
    constructor(value, left, right) {
        super();
        this.value = value;
        this.left = left;
        this.right = right;
        this._size = 1 + left.size() + right.size();
        Object.freeze(this);
    }
    size() { return this._size; }
    contains(x) {
        const c = cmp(x, this.value);
        if (c === 0)
            return true;
        return c < 0 ? this.left.contains(x) : this.right.contains(x);
    }
    insert(x) {
        const c = cmp(x, this.value);
        if (c === 0)
            return this;
        if (c < 0)
            return new Node(this.value, this.left.insert(x), this.right);
        return new Node(this.value, this.left, this.right.insert(x));
    }
    *inorder() {
        yield* this.left.inorder();
        yield this.value;
        yield* this.right.inorder();
    }
    toString() {
        const L = this.left.toString();
        const R = this.right.toString();
        const leftPart = L === "()" ? "" : L;
        const rightPart = R === "()" ? "" : R;
        return `(${leftPart}${String(this.value)}${rightPart})`;
    }
}
