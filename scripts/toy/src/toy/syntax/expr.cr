require "colorize"

module Toy::Syntax
  class Expr
    macro subclass(name, value_type)
      class {{name}} < Expr
        property value : {{value_type}}

        def initialize(@value : {{value_type}});end
      end
    end

    def pretty_print(printer)
      color = {
        value_type: :yellow,
        value: :magenta,
        brack: :green,
        paren: :cyan
      }
      l_paren, r_paren = "()".split("").map { |s| s.colorize(color[:paren]) }
      l_brack, r_brack = "[]".split("").map { |s| s.colorize(color[:brack]) }

      printer.surround(l_paren, r_paren, nil, nil) do
        printer.text(
          "#{self.class.to_s.split("::").last.colorize(color[:value_type])} "
        )
        case self
        when Identifier, Integer, Operator
          if responds_to?(:value)
            printer.text(self.value.colorize(color[:value]))
          end
        when Module, Quote
          printer.surround(l_brack, r_brack, "", nil) do
            printer.list(nil, self.value, nil)
          end
        else
          error!("#pretty_print: Unhandled case.")
        end
      end
    end

    private def error!(message) : NoReturn
      abort "#{self.class}: #{message}"
    end
  end

  Expr.subclass(Identifier, String)
  Expr.subclass(Integer, Int32)
  Expr.subclass(Module, Array(Expr))
  Expr.subclass(Operator, String)
  Expr.subclass(Quote, Array(Expr))
end
