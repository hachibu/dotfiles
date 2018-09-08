require "string_scanner"

class Toy::Reader
  def initialize(input : String)
    @scanner = StringScanner.new(input)
  end

  def error!(message)
    abort "Reader error: #{message}: '#{@scanner.rest}'"
  end

  def read
    tokens = [] of Token
    until @scanner.eos?
      case
      when token = read_expr
        tokens << token
      else
        error!("Unparsable input")
      end
      skip_ws
    end
    Token.new(Token::Type::Module, tokens)
  end

  def read_expr
    skip_ws
    read_op || read_id || read_int || read_quote
  end

  def skip_ws
    @scanner.skip(/\s+/)
  end

  macro define_reader(name, type, pattern, action = nil)
    def read_{{name}}
      if w = @scanner.scan({{pattern}})
        Token.new(
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
    def read_{{name}}
      opening_re = Regex.new(Regex.escape({{opening}}))
      closing_re = Regex.new(Regex.escape({{closing}}))
      if @scanner.scan(opening_re)
        tokens = [] of Token
        opening_offset = @scanner.offset - 1
        until @scanner.peek(1) == {{closing}} || @scanner.eos?
          if token = read_expr
            tokens << token
          end
        end
        if @scanner.scan(closing_re)
          return Token.new({{type}}, tokens)
        else
          @scanner.offset = opening_offset
          error!("Unbalanced {{name}}")
        end
      end
    end
  end

  define_reader(op, Token::Type::Operator, /\.|:|\+|-|\*|\/|%/)
  define_reader(id, Token::Type::Identifier, /[_a-zA-Z][_a-zA-Z0-9]*/)
  define_reader(int, Token::Type::Integer, /\d+/, to_i)
  define_nested_reader(quote, Token::Type::Quote, "[", "]")
end
