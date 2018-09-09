require "string_scanner"

class Toy::Reader
  def initialize(input : String)
    @scanner = StringScanner.new(input)
  end

  def read : Expr
    exprs = [] of Expr
    until @scanner.eos?
      if expr = read_expr
        exprs << expr
      else
        error!("Unparsable input")
      end
    end
    Expr.new(Expr::Type::Module, exprs)
  end

  def read_expr : Expr?
    skip_whitespace { read_op || read_id || read_int || read_quote }
  end

  macro define_reader(name, type, pattern, action = nil)
    def read_{{name}} : Expr?
      if w = @scanner.scan({{pattern}})
        Expr.new(
          {{type}},
          {% if action %}
            w.{{action}}
          {% else %}
            w
          {% end %}
        )
      end
    end
  end

  macro define_nested_reader(name, type, opening, closing)
    def read_{{name}} : Expr?
      opening_re = Regex.new(Regex.escape({{opening}}))
      closing_re = Regex.new(Regex.escape({{closing}}))
      if @scanner.scan(opening_re)
        exprs = [] of Expr
        opening_offset = @scanner.offset - 1
        until @scanner.peek(1) == {{closing}} || @scanner.eos?
          if expr = read_expr
            exprs << expr
          end
        end
        if @scanner.scan(closing_re)
          return Expr.new({{type}}, exprs)
        else
          @scanner.offset = opening_offset
          error!("Unbalanced {{name}}")
        end
      end
    end
  end

  define_reader(op, Expr::Type::Operator, /\.|:|\+|-|\*|\/|%/)
  define_reader(id, Expr::Type::Identifier, /[_a-zA-Z][_a-zA-Z0-9]*/)
  define_reader(int, Expr::Type::Integer, /\d+/, to_i)
  define_nested_reader(quote, Expr::Type::Quote, "[", "]")

  def skip_whitespace : Expr?
    @scanner.skip(/\s+/)
    value = yield
    @scanner.skip(/\s+/)
    value
  end

  def error!(message) : NoReturn
    abort "Reader error: #{message}: '#{@scanner.rest}'"
  end
end
