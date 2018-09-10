require "colorize"

module Toy::Syntax
  class Expr
    macro subclass(name, value_type)
      class Toy::Syntax::{{name}} < Toy::Syntax::Expr
        property value : {{value_type}}
        def initialize(@value : {{value_type}}); end
      end
    end

    def pretty_print(printer)
      type_color, value_color = [:yellow, :magenta]
      brack_color, paren_color = [:green, :cyan]

      printer.surround("(".colorize(paren_color), ")".colorize(paren_color), nil, nil) do
        printer.text("#{self.base_class.colorize(type_color)} ")
        case self
        when Identifier, Integer, Operator
          if self.responds_to?(:value)
            printer.text(self.value.colorize(value_color))
          end
        when Module, Quote
          printer.surround("[".colorize(brack_color), "]".colorize(brack_color), "", nil) do
            printer.list(nil, self.value, nil)
          end
        else
          error!("#pretty_print: Unhandled case.")
        end
      end
    end

    private def base_class
      self.class.to_s.sub("Toy::Syntax::", "")
    end

    private def error!(message) : NoReturn
      abort "#{self.class}: #{message}"
    end
  end

  Expr.subclass(Identifier, String)
  Expr.subclass(Integer,    Int32)
  Expr.subclass(Module,     Array(Expr))
  Expr.subclass(Operator,   String)
  Expr.subclass(Quote,      Array(Expr))
end
