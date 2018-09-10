require "colorize"

module Toy::Syntax
  class Expr
    def pretty_print(printer)
      type_color, value_color = [:yellow, :magenta]
      brack_color, paren_color = [:green, :cyan]

      printer.text("(".colorize(paren_color))
      printer.text(
        self.class.to_s.sub("Toy::Syntax::", "").colorize(type_color)
      )
      printer.text(" ")

      case self
      when Identifier, Integer, Operator
        if self.responds_to?(:value)
          printer.text(self.value.colorize(value_color))
        end
      when Module, Quote
        printer.nest do
          printer.list(
            "[".colorize(brack_color),
            self.value,
            "]".colorize(brack_color)
          )
        end
      else
        error!("#pretty_print: Unhandled case.")
      end

      printer.text(")".colorize(paren_color))
    end

    def error!(message) : NoReturn
      abort "#{self.class}: #{message}"
    end

    macro subclass(name, value_type)
      class Toy::Syntax::{{name}} < Toy::Syntax::Expr
        property value : {{value_type}}
        def initialize(@value : {{value_type}}); end
      end
    end
  end

  Expr.subclass(Identifier, String)
  Expr.subclass(Integer,    Int32)
  Expr.subclass(Module,     Array(Expr))
  Expr.subclass(Operator,   String)
  Expr.subclass(Quote,      Array(Expr))
end
