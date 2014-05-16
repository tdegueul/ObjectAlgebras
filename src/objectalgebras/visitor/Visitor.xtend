package objectalgebras.visitor

interface Expr {
	def void accept(Visitor v)
}

interface Visitor {
	def void visitLit(ExprLit e)
	def void visitAdd(ExprAdd e)
}

class ExprLit implements Expr {
	public int v

	new (int vv) { v = vv }
	override accept(Visitor v) { v.visitLit(this) }
}

class ExprAdd implements Expr {
	public Expr lhs
	public Expr rhs

	new(Expr l, Expr r) { lhs = l ; rhs = r }
	override accept(Visitor v) { v.visitAdd(this) }
}

// Adding new operations is easy (and ugly)
/*class Eval implements Visitor {
	override visitLit(ExprLit e) { println(e.v) }
	override visitAdd(ExprAdd e) { e.lhs.accept(this) ; e.rhs.accept(this) }
}*/

class VisitorMain {
	def static void main(String[] args) {
		val x = new ExprAdd(new ExprLit(1), new ExprLit(2))
		//x.accept(new Eval)
	}
}
