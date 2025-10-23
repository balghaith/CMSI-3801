export function firstThenApply<A, B>(
    as: ReadonlyArray<A>,
    p: (a: A) => boolean,
    f: (a: A) => B
): B | undefined {
    const found: A | undefined = as.find(p);
    return found === undefined ? undefined : f(found);
}

export function* powersGenerator(base: bigint): Generator<bigint, never, void> {
    let current: bigint = 1n;
    while (true) {
        yield current;
        current *= base;
    }
}

import * as fs from "node:fs";
import * as readline from "node:readline";

export async function meaningfulLineCount(filePath: string): Promise<number> {
    const stream = fs.createReadStream(filePath, { encoding: "utf8" });
    const rl = readline.createInterface({ input: stream, crlfDelay: Infinity });

    let count = 0;
    try {
        for await (const raw of rl) {
            const line = String(raw).trim();
            if (line.length === 0) continue;
            if (line.startsWith("#")) continue;
            count += 1;
        }
        return count;
    } finally {
        rl.close();
    }
}

export type Sphere = Readonly<{ kind: "Sphere"; radius: number }>;
export type Box = Readonly<{ kind: "Box"; width: number; length: number; depth: number }>;
export type Shape = Sphere | Box;

export function surfaceArea(s: Shape): number {
    switch (s.kind) {
        case "Sphere":
            return 4 * Math.PI * s.radius * s.radius;
        case "Box":
            return 2 * (s.width * s.length + s.width * s.depth + s.length * s.depth);

    }
}

export function volume(s: Shape): number {
    switch (s.kind) {
      case "Sphere":
        return (4 / 3) * Math.PI * s.radius * s.radius * s.radius;
      case "Box":
        return s.width * s.length * s.depth;
    }
  }

  type Orderable = string | number | boolean | bigint;

  function cmp<T extends Orderable>(a: T, b: T): number {
    return (a as any) < (b as any) ? -1 : (a as any) > (b as any) ? 1 : 0;
  }

  export abstract class BinarySearchTree<T extends Orderable> {

    abstract size(): number;
    abstract contains(value: T): boolean;
    abstract insert(value: T): BinarySearchTree<T>;
    abstract inorder(): Generator<T, void, void>;
    abstract toString(): string;
  }

  export class Empty<T extends Orderable> extends BinarySearchTree<T> {
    size(): number { return 0; }
    contains(_value: T): boolean { return false; }
    insert(value: T): BinarySearchTree<T> { return new Node<T>(value, this, this); }
    *inorder(): Generator<T, void, void> { }
    toString(): string { return "()"; }
  }

  class Node<T extends Orderable> extends BinarySearchTree<T> {
    public readonly value: T;
    public readonly left: BinarySearchTree<T>;
    public readonly right: BinarySearchTree<T>;
    private readonly _size: number;

    constructor(value: T, left: BinarySearchTree<T>, right: BinarySearchTree<T>) {
        super();
        this.value = value;
        this.left = left;
        this.right = right;
        this._size = 1 + left.size() + right.size(); 
        Object.freeze(this);
    }

    size(): number { return this._size; }

    contains(x: T): boolean {
        const c = cmp(x, this.value);
        if (c === 0) return true;
        return c < 0 ? this.left.contains(x) : this.right.contains(x);
    }

    insert(x: T): BinarySearchTree<T> {
        const c = cmp(x, this.value)
        if (c === 0) return this;
        if (c < 0) return new Node(this.value, this.left.insert(x), this.right);
        return new Node(this.value, this.left, this.right.insert(x));
    }

    *inorder(): Generator<T, void, void> {
        yield* this.left.inorder();
        yield this.value;
        yield* this.right.inorder();
    }

    toString(): string {
        const L = this.left.toString();
        const R = this.right.toString();
        const leftPart = L === "()" ? "" : L;
        const rightPart = R === "()" ? "" : R;
        return `(${leftPart}${String(this.value)}${rightPart})`;
    }
}
