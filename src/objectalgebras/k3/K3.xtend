package objectalgebras.k3

import fr.inria.diverse.k3.al.annotationprocessor.Aspect
import fr.inria.diverse.k3.al.annotationprocessor.OverrideAspectMethod

import static extension objectalgebras.k3.AddPrintAspect.*

interface Expr {}

class Lit implements Expr {
	@Property int value
	new(int v) { value = v }
}

class Add implements Expr {
	@Property Expr lhs
	@Property Expr rhs
	new(Expr l, Expr r) { lhs = l ; rhs = r }
}

class Mul implements Expr {
	@Property Expr lhs
	@Property Expr rhs
	new(Expr l, Expr r) { lhs = l ; rhs = r }
}

@Aspect(className = Expr)
abstract class ExprPrintAspect {
	def String print()
	def int eval()
}

@Aspect(className = Lit)
class LitPrintAspect extends ExprPrintAspect {
	@OverrideAspectMethod
	def print() { _self.value.toString }
	@OverrideAspectMethod
	def eval() { _self.value }
}

@Aspect(className = Add)
class AddPrintAspect extends ExprPrintAspect {
	@OverrideAspectMethod
	def print() { _self.lhs.print + " + " + _self.rhs.print }
	@OverrideAspectMethod
	def eval() { _self.lhs.eval + _self.rhs.eval }
}

@Aspect(className = Mul)
class MulPrintAspect extends ExprPrintAspect {
	@OverrideAspectMethod
	def print() { _self.lhs.print + " * " + _self.rhs.print }
	@OverrideAspectMethod
	def eval() { _self.lhs.eval * _self.rhs.eval }
}

class K3
{
	def static void main(String[] args) {
		val x = new Add(new Lit(1), new Add(new Lit(2), new Lit(3)))
		println(x.print)
		println(x.eval)

		val y = new Add(new Mul(new Lit(1), new Lit(2)), new Lit(3))
		println(y.print)
		println(y.eval)
	}
}
