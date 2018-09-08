class Toy::Token
  enum Type
    Identifier
    Integer
    Module
    Operator
    Quote
  end

  alias Value = Int32 | String | Array(Toy::Token)

  def initialize(@type : Type, @value : Value); end
end
