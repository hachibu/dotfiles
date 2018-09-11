require "string_scanner"

module Toy::Syntax
  class Reader
    getter scanner : StringScanner

    def initialize(input : String)
      @scanner = StringScanner.new(input)
    end

    macro define_reader(type, pattern, action = nil)
      def read_{{type}} : Expr?
        if v = scanner.scan({{pattern}})
          {{type}}.new({% if action %}v.{{action}}{% else %}v{% end %})
        end
      end
    end

    macro define_nested_reader(type, opening, closing)
      def read_{{type}} : Expr?
        opening_re = Regex.new(Regex.escape({{opening}}))
        closing_re = Regex.new(Regex.escape({{closing}}))

        if scanner.scan(opening_re)
          exprs = [] of Expr
          opening_offset = scanner.offset - 1

          until scanner.peek(1) == {{closing}} || scanner.eos?
            if expr = read_expr
              exprs << expr
            end
          end

          if scanner.scan(closing_re)
            return {{type}}.new(exprs)
          else
            scanner.offset = opening_offset
            error!("#read_{{type}}: Unbalanced {{type}}")
          end
        end
      end
    end

    def read : Expr?
      return if scanner.eos?
      exprs = [] of Expr
      until scanner.eos?
        if expr = read_expr
          exprs << expr
        else
          error!("#read: Unparsable input")
        end
      end
      Module.new(exprs)
    end

    def read_expr : Expr?
      scanner.skip(/\s+/)
      expr = read_Operator || read_Identifier || read_Integer || read_Quote
      scanner.skip(/\s+/)
      expr
    end

    define_reader(Identifier, /[_a-zA-Z][_a-zA-Z0-9]*/)
    define_reader(Integer, /\d+/, to_i)
    define_reader(Operator, /\.|:|\+|-|\*|\/|%/)
    define_nested_reader(Quote, "[", "]")

    private def error!(message) : NoReturn
      abort "#{self.class}: #{message}: \"#{scanner.rest}\""
    end
  end
end
