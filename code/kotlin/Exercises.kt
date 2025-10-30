import java.io.BufferedReader
import java.io.FileReader

fun <A, B> firstThenApply(a: Array<A>, p: (A) -> Boolean, f: (A) -> B): B? =
    a.firstOrNull(p)?.let(f)
fun firstThenLowerCase(xs: List<String>, p: (String) -> Boolean): String? =
    xs.firstOrNull(p)?.lowercase()

class Phrase private constructor(val phrase: String) {
    fun and(next: String): Phrase = Phrase("$phrase $next")
    companion object {
        fun say(): Phrase = Phrase("")
        fun say(s: String): Phrase = Phrase(s)
    }
}

fun say(): Phrase = Phrase.say()
fun say(s: String): Phrase = Phrase.say(s)
fun meaningfulLineCount(filename: String): Long =
    BufferedReader(FileReader(filename)).use { br ->
        br.lineSequence()
            .map { it.trim() }
            .filter { it.isNotEmpty() }
            .filter { !it.startsWith("#") }
            .count().toLong()
    }

data class Quaternion(val a: Double, val b: Double, val c: Double, val d: Double) {
    init {
        require(!(a.isNaN() || b.isNaN() || c.isNaN() || d.isNaN()))
    }
    operator fun plus(q: Quaternion) = Quaternion(a + q.a, b + q.b, c + q.c, d + q.d)
    operator fun times(q: Quaternion) = Quaternion(
        a * q.a - b * q.b - c * q.c - d * q.d,
        a * q.b + b * q.a + c * q.d - d * q.c,
        a * q.c - b * q.d + c * q.a + d * q.b,
        a * q.d + b * q.c - c * q.b + d * q.a
    )
    fun conjugate() = Quaternion(a, -b, -c, -d)
    fun coefficients() = listOf(a, b, c, d)
    override fun toString(): String {
        val parts = mutableListOf<String>()
        if (a != 0.0) parts += a.toString()
        fun add(coef: Double, sym: String) {
            if (coef == 0.0) return
            val mag = if (kotlin.math.abs(coef) == 1.0) "" else kotlin.math.abs(coef).toString()
            val sign = if (coef < 0) "-" else if (parts.isEmpty()) "" else "+"
            parts += sign + mag + sym
        }
        add(b, "i")
        add(c, "j")
        add(d, "k")
        return if (parts.isEmpty()) "0" else parts.joinToString("")
    }
    companion object {
        val ZERO = Quaternion(0.0, 0.0, 0.0, 0.0)
        val I = Quaternion(0.0, 1.0, 0.0, 0.0)
        val J = Quaternion(0.0, 0.0, 1.0, 0.0)
        val K = Quaternion(0.0, 0.0, 0.0, 1.0)
    }

}
sealed interface BinarySearchTree {
    fun insert(value: String): BinarySearchTree
    fun contains(value: String): Boolean
    fun size(): Int
    data class Node(
        val value: String,
        val left: BinarySearchTree,
        val right: BinarySearchTree
    ) : BinarySearchTree {
        override fun insert(value: String): BinarySearchTree = 
            when {
                value == this.value -> this
                value < this.value -> Node(this.value, left.insert(value), right)
                else -> Node(this.value, left, right.insert(value))
            }
        override fun contains(value: String): Boolean =
            when {
                value == this.value -> true
                value < this.value -> left.contains(value)
                else -> right.contains(value)
            }
        override fun size(): Int = 1 + left.size() + right.size()
        override fun toString(): String = "(${left.toString()}${value}${right.toString()})".replace("()", "")
    }
    object Empty : BinarySearchTree {
        override fun insert(value: String): BinarySearchTree =
            Node(value, Empty, Empty)
        override fun contains(value: String): Boolean = false
        override fun size(): Int = 0
        override fun toString(): String = "()"
    }
}