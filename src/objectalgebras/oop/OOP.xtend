package objectalgebras.oop

interface Expr {
	def int eval()
	// abstract def int print() <- New operations break implementers
}

class ExprLit implements Expr {
	int v

	new(int vv) { v = vv }
	override eval() { v }
}

class ExprAdd implements Expr {
	Expr lhs
	Expr rhs

	new(Expr l, Expr r) { lhs = l ; rhs = r }
	override eval() { lhs.eval + rhs.eval }
}

// Adding new variants is easy
class ExprMul implements Expr {
	Expr lhs
	Expr rhs

	new (Expr l, Expr r) { lhs = l ; rhs = r }
	override eval() { lhs.eval * rhs.eval }
}

class OOP {
	static def void main(String[] args) {
		val x = new ExprAdd(new ExprLit(1), new ExprAdd(new ExprLit(2), new ExprLit(3)))
		println(x.eval)
		// println(y.print)

		val y = new ExprMul(new ExprAdd(new ExprLit(1), new ExprLit(2)), new ExprLit(3))
		println(y.eval)
		// println(y.print)
	}
}
