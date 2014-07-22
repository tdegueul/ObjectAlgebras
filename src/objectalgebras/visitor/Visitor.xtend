package objectalgebras.visitor

interface Expr {
	def <T> T accept(Visitor<T> v)
}

interface Visitor<T> {
	def T visitLit(ExprLit e)
	def T visitAdd(ExprAdd e)
}

class ExprLit implements Expr {
	@Property int v

	new (int vv) { v = vv }
	override <T> T accept(Visitor<T> v) { v.visitLit(this) }
}

class ExprAdd implements Expr {
	@Property Expr lhs
	@Property Expr rhs

	new(Expr l, Expr r) { lhs = l ; rhs = r }
	override <T> T accept(Visitor<T> v) { v.visitAdd(this) }
}

// Adding new operations is easy
class Eval implements Visitor<Integer> {
	override visitLit(ExprLit e) { e.v }
	override visitAdd(ExprAdd e) { e.lhs.accept(this) + e.rhs.accept(this) }
}

class Print implements Visitor<String> {
	override visitLit(ExprLit e) { e.v.toString }
	override visitAdd(ExprAdd e) { e.lhs.accept(this) + " + " + e.rhs.accept(this) }
}

class VisitorMain {
	def static void main(String[] args) {
		val x = new ExprAdd(new ExprLit(1), new ExprLit(2))
		println(x.accept(new Eval))
		println(x.accept(new Print))
	}
}
