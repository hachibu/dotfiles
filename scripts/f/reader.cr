require "string_scanner"

class Reader
  alias Token = Tuple(TokenType, TokenValue)
  enum TokenType
    Identifier
    Integer
    Module
    Operator
    Quote
  end
  alias TokenValue = Int32 | String | Array(Token)

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
    {TokenType::Module, tokens}
  end

  def read_expr
    skip_ws
    read_op || read_id || read_int || read_quote
  end

  def skip_ws
    @scanner.skip(/\s+/)
  end

  macro define_reader(name, type, pattern)
    def read_{{name}}
      if w = @scanner.scan({{pattern}})
        Tuple.new({{type}}, w)
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
          return Tuple.new({{type}}, tokens)
        else
          @scanner.offset = opening_offset
          error!("Unbalanced {{name}}")
        end
      end
    end
  end

  define_reader(op, TokenType::Operator, /\.|:|\+|-|\*|\/|%/)
  define_reader(id, TokenType::Identifier, /[_a-zA-Z][_a-zA-Z0-9]*/)
  define_reader(int, TokenType::Integer, /\d+/)
  define_nested_reader(quote, TokenType::Quote, "[", "]")
end
