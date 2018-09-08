class Toy::Token
  enum Type
    Identifier
    Integer
    Module
    Operator
    Quote
  end

  alias Value = Int32 | String | Array(Token)

  def initialize(@type : Type, @value : Value); end
end
