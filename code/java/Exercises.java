import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;
import java.util.function.*;

public class Exercises {
    public static <T, R> Optional<R> firstThenApply(T[] a, Predicate<T> p, Function<T, R> f) {
        return Arrays.stream(a).filter(p).findFirst().map(f);
    }
    public static Optional<String> firstThenLowerCase(String[] a, Predicate<String> p) {
        return firstThenApply(a, p, String::toLowerCase);
    }
    public static Optional<String> firstThenLowerCase(List<String> a, Predicate<String> p) {
        return a.stream().filter(p).findFirst().map(String::toLowerCase);
    }
    public static final class Phrase {
        public final String phrase;
        private Phrase(String phrase) { this.phrase = phrase; }
        public Phrase() { this(""); }
        public Phrase and(String next) { return new Phrase(phrase + " " + next); }
        public String phrase() { return phrase; }
    }
    public static Phrase say() { return new Phrase(); }
    public static Phrase say(String s) { return new Phrase(s); }
    public static long meaningfulLineCount(String filename) throws IOException {
        try (BufferedReader br = new BufferedReader(new FileReader(filename))) {
            return br.lines()
                     .map(String::trim)
                     .filter(line -> !line.isEmpty())
                     .filter(line -> !line.startsWith("#"))
                     .count();
        }
    }
}

record Quaternion(double a, double b, double c, double d) {
    public static final Quaternion ZERO = new Quaternion(0,0,0,0);
    public static final Quaternion I = new Quaternion(0,1,0,0);
    public static final Quaternion J = new Quaternion(0,0,1,0);
    public static final Quaternion K = new Quaternion(0,0,0,1);
    public Quaternion {
        if (Double.isNaN(a) || Double.isNaN(b) || Double.isNaN(c) || Double.isNaN(d)) {
            throw new IllegalArgumentException("Coefficients cannot be NaN");
        }
    }
    public double a() { return a; }
    public double b() { return b; }
    public double c() { return c; }
    public double d() { return d; }
    public Quaternion plus(Quaternion q) {
        return new Quaternion(a + q.a, b + q.b, c + q.c, d + q.d);
    }
    public Quaternion times(Quaternion q) {
        return new Quaternion(
            a*q.a - b*q.b - c*q.c - d*q.d,
            a*q.b + b*q.a + c*q.d - d*q.c,
            a*q.c - b*q.d + c*q.a + d*q.b,
            a*q.d + b*q.c - c*q.b + d*q.a           
        );
    }
    public Quaternion conjugate() {
        return new Quaternion(a, -b, -c, -d);
    }
    public List<Double> coefficients() {
        return List.of(a, b, c, d);
    }
    @Override public String toString() {
        List<String> parts = new ArrayList<>();
        if (a != 0.0 && a != -0.0) parts.add(Double.toString(a));
        BiConsumer<Double,String> addImag = (coef, unit) -> {
            if (coef == 0.0 || coef == -0.0) return;
            String mag = Math.abs(coef) == 1.0 ? "" : Double.toString(Math.abs(coef));
            String term = (coef < 0 ? "-" : "+") + mag + unit;
            parts.add(term);           
        };
        addImag.accept(b, "i");
        addImag.accept(c, "j");
        addImag.accept(d, "k");
        if (parts.isEmpty()) return "0"; 
        String s = String.join("", parts);
        if (s.charAt(0) == '+') s = s.substring(1);
        return s;
    }
}

sealed interface BinarySearchTree<T extends Comparable<T>> permits Empty, Node {
    BinarySearchTree<T> insert(T value);
    boolean contains(T value);
    int size();
    String toString();
}

final class Empty<T extends Comparable<T>> implements BinarySearchTree<T> {
    @Override public BinarySearchTree<T> insert(T value) {
        return new Node<>(value, new Empty<>(), new Empty<>());
    }
    @Override public boolean contains(T value) { return false; }
    @Override public int size() { return 0; }
    @Override public String toString() { return "()"; }
}

final class Node<T extends Comparable<T>> implements BinarySearchTree<T> {
    private final T value;
    private final BinarySearchTree<T> left;
    private final BinarySearchTree<T> right;
    Node(T value, BinarySearchTree<T> left, BinarySearchTree<T> right) {
        this.value = value;
        this.left = left;
        this.right = right;
    }
    @Override public BinarySearchTree<T> insert(T v) {
        int cmp = v.compareTo(value);
        if (cmp == 0) return this;
        if (cmp < 0) return new Node<>(value, left.insert(v), right);
        return new Node<>(value, left, right.insert(v));
    }
    @Override public boolean contains(T v) {
        int cmp = v.compareTo(value);
        if (cmp == 0) return true;
        return (cmp < 0) ? left.contains(v) : right.contains(v);
    }
    @Override public int size() { return 1 + left.size() + right.size(); }
    @Override public String toString() {
        StringBuilder sb = new StringBuilder("(");
        if (left.size() > 0) sb.append(left.toString());
        sb.append(value);
        if (right.size() > 0) sb.append(right.toString());
        sb.append(")");
        return sb.toString();
    }

}



