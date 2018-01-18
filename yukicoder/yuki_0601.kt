import java.util.*

fun main(args: Array<String>) {
	val cin = Scanner(System.`in`)
	val N = cin.nextInt()
	val A = Array(4, {i -> 0})

	for (i in 1..N) {
		val x = cin.nextInt()
		val y = cin.nextInt()
		A[x%2*2 + y%2] += 1
	}

	val num = A.map{a -> a / 2}.sum() as Int
	val ans = if (num % 2 == 1) "Alice" else "Bob"
	println(ans)
}
