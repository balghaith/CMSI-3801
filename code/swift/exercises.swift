import Foundation

public func firstThenLowerCase(of array: [String], satisfying p: (String) -> Bool) -> String? {
    array.first(where: p)?.lowercased()
}
public struct PhraseBuilder {
    private let words: [String]
    fileprivate init(_ words: [String]) { self.words = words }
    public func and(_ word: String) -> PhraseBuilder { PhraseBuilder(words + [word]) }
    public var phrase: String { words.joined(separator: " ") }
}
public func say() -> PhraseBuilder { PhraseBuilder([]) }
public func say(_ word: String) -> PhraseBuilder { PhraseBuilder([word]) }
public func meaningfulLineCount(_ filename: String) async -> Result<Int, Error> {
    do {
        let text = try String(contentsOfFile: filename, encoding: .utf8)
        let n = text.split(separator: "\n", omittingEmptySubsequences: false).filter { line in
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            return !trimmed.isEmpty && !trimmed.hasPrefix("#")
        }.count
        return .success(n)
    } catch {
        return .failure(error)
    }
}
public struct Quaternion: Equatable, CustomStringConvertible {
    public let a: Double, b: Double, c: Double, d: Double
    public static let ZERO = Quaternion(0,0,0,0)
    public static let I = Quaternion(0,1,0,0)
    public static let J = Quaternion(0,0,1,0)
    public static let K = Quaternion(0,0,0,1)
    public init(_ a: Double, _ b: Double, _ c: Double, _ d: Double) {
        self.a = a; self.b = b; self.c = c; self.d = d
    }
    public init(a: Double = 0, b: Double = 0, c: Double = 0, d: Double = 0) {
        self.init(a, b, c, d)
    }
    public var conjugate: Quaternion { Quaternion(a, -b, -c, -d) }
    public var coefficients: [Double] { [a, b, c, d] }
    public static func +(x: Quaternion, y: Quaternion) -> Quaternion {
        Quaternion(x.a + y.a, x.b + y.b, x.c + y.c, x.d + y.d)
    }
    public static func *(x: Quaternion, y: Quaternion) -> Quaternion {
        Quaternion(x.a*y.a - x.b*y.b - x.c*y.c - x.d*y.d,
                   x.a*y.b + x.b*y.a + x.c*y.d - x.d*y.c,
                   x.a*y.c - x.b*y.d + x.c*y.a + x.d*y.b,
                   x.a*y.d + x.b*y.c - x.c*y.b + x.d*y.a
        )  
    }
    public var description: String {
        if a == 0 && b == 0 && c == 0 && d == 0 { return "0" }
        var parts: [String] = []
        if a != 0 { parts.append("\(a)") }
        func term(_ coef: Double, _ sym: String) {
            if coef == 0 { return }
            let sign = coef < 0 ? "-" : (parts.isEmpty ? "" : "+")
            let mag = abs(coef)
            if mag == 1 { parts.append("\(sign)\(sym)") }
            else { parts.append("\(sign)\(mag)\(sym)") }
        }
        term(b, "i"); term(c, "j"); term(d, "k")
        return parts.joined()
    }
}
public indirect enum BinarySearchTree {
    case empty
    case node(String, BinarySearchTree, BinarySearchTree)
    public static var Empty: BinarySearchTree { .empty }
    public func insert(_ value: String) -> BinarySearchTree {
        switch self {
            case .empty: return .node(value, .empty, .empty)
            case let .node(v, l, r):
                if value < v { return .node(v, l.insert(value), r) }
                if value > v { return .node(v, l, r.insert(value)) }
                return self
        }
    }
    public func contains(_ value: String) -> Bool {
        switch self {
            case .empty: return false
            case let .node(v, l, r):
                if value == v { return true }
                return value < v ? l.contains(value) : r.contains(value)
        }
    }
    public var size: Int {
        switch self {
            case .empty: return 0
            case let .node(_, l, r): return 1 + l.size + r.size
        }
    }
}
extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        switch self {
        case .empty:
            return "()"
        case let .node(v, l, r):
            var s = "("
            if case .empty = l {} else { s += l.description }
            s += v
            if case .empty = r {} else { s += r.description }
            s += ")"
            return s
        }
    }
}

