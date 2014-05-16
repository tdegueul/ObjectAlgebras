package objectalgebras.oa

interface ExpAlg<E> {
	def E createLit(int v)
	def E createAdd(E lhs, E rhs)
}

interface Print {
	def String print()
}

class PrintExp implements ExpAlg<Print> {
	override createLit(int v) { new PrintLit(v) }
	override createAdd(Print lhs, Print rhs) { new PrintAdd(lhs, rhs) }
}

class PrintAdd implements Print {
	Print lhs
	Print rhs

	new(Print l, Print r) { lhs = l ; rhs = r }
	override print() { lhs.print + " + " + rhs.print }
}

class PrintLit implements Print {
	int v

	new(int vv) { v = vv }
	override print() { v.toString }
}

// New variant Mul
interface MulAlg<E> extends ExpAlg<E> {
	def E createMul(E lhs, E rhs)
}

class PrintMulExp extends PrintExp implements MulAlg<Print> {
	override createMul(Print lhs, Print rhs) { new PrintMul(lhs, rhs) }
}

class PrintMul implements Print {
	Print lhs
	Print rhs

	new(Print l, Print r) { lhs = l ; rhs = r }
	override print() { lhs.print + " * " + rhs.print }
}

// New operation eval
interface Eval {
	def int eval()
}

class EvalExp implements ExpAlg<Eval> {
	override createLit(int v) { new EvalLit(v) }
	override createAdd(Eval lhs, Eval rhs) { new EvalAdd(lhs, rhs) }
}

class EvalMulExp extends EvalExp implements MulAlg<Eval> {
	override createMul(Eval lhs, Eval rhs) { new EvalMul(lhs, rhs) }
}

class EvalLit implements Eval {
	int v

	new(int vv) { v = vv }
	override eval() { v }
}

class EvalAdd implements Eval {
	Eval lhs
	Eval rhs

	new(Eval l, Eval r) { lhs = l ; rhs = r }
	override eval() { lhs.eval + rhs.eval }
}

class EvalMul implements Eval {
	Eval lhs
	Eval rhs

	new(Eval l, Eval r) { lhs = l ; rhs = r }
	override eval() { lhs.eval * rhs.eval }
}

class ObjectAlgebras
{
	def static void main(String[] args) {
		val x = makePrintExp1(new PrintExp)
		println(x.print)

		val y = makePrintExp2(new PrintExp)
		println(y.print)

		val z = makePrintExp3(new PrintMulExp)
		println(z.print)

		val x_ = makeEvalExp1(new EvalExp)
		println(x_.eval)

		val y_ = makePrintExp2(new EvalExp)
		println(y_.eval)

		val z_ = makePrintExp3(new EvalMulExp)
		println(z_.eval)
	}

	def static <E> makePrintExp1(ExpAlg<E> fact) {
		fact.createAdd(fact.createLit(1), fact.createLit(2))
	}

	def static <E> makePrintExp2(ExpAlg<E> fact) {
		fact.createAdd(fact.createLit(1), fact.createAdd(fact.createLit(3), fact.createLit(5)))
	}

	def static <E> makePrintExp3(MulAlg<E> fact) {
		fact.createAdd(fact.createLit(1), fact.createMul(fact.createLit(3), fact.createLit(5)))
	}

	def static <E> makeEvalExp1(ExpAlg<E> fact) {
		fact.createAdd(fact.createLit(1), fact.createLit(2))
	}

	def static <E> makeEvalExp2(ExpAlg<E> fact) {
		fact.createAdd(fact.createLit(1), fact.createAdd(fact.createLit(3), fact.createLit(5)))
	}

	def static <E> makeEvalExp3(MulAlg<E> fact) {
		fact.createAdd(fact.createLit(1), fact.createMul(fact.createLit(3), fact.createLit(5)))
	}
}
