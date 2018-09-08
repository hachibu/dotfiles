class Toy::Expr
  enum Type
    Identifier
    Integer
    Module
    Operator
    Quote
  end

  alias Value = Int32 | String | Array(Expr)

  def initialize(@type : Type, @value : Value); end
end
