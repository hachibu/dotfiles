require "colorize"

module Toy::Syntax
  class Expr
    property value

    def pretty_print(printer)
      type_color, value_color = [:yellow, :magenta]
      brack_color, paren_color = [:green, :cyan]

      printer.text("(".colorize(paren_color))
      printer.text(self.class.to_s.sub("Toy::Syntax::", "").colorize(type_color))
      printer.text(" ")
      case self
      when Toy::Syntax::Integer
        printer.text(self.value.colorize(value_color))
      when Toy::Syntax::Identifier, Toy::Syntax::Operator
        printer.text(self.value.colorize(value_color))
      when Toy::Syntax::Module, Toy::Syntax::Quote
        printer.nest do
          printer.list(
            "[".colorize(brack_color),
            self.value,
            "]".colorize(brack_color)
          )
        end
      end
      printer.text(")".colorize(paren_color))
    end
  end

  class Identifier < Expr
    def initialize(@value : String); end
  end

  class Integer < Expr
    def initialize(@value : Int32); end
  end

  class Module < Expr
    def initialize(@value : Array(Expr)); end
  end

  class Operator < Expr
    def initialize(@value : String); end
  end

  class Quote < Expr
    def initialize(@value : Array(Expr)); end
  end
end
