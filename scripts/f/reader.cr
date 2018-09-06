require "string_scanner"

class Reader
  alias Token = Int32 | String | Array(Token)

  def initialize(input : String)
    @scanner = StringScanner.new(input)
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

    tokens
  end

  def error!(message)
    abort "Reader error: #{message}: '#{@scanner.rest}'"
  end

  def read_expr
    skip_ws
    read_op || read_id || read_int || read_quote
  end

  def skip_ws
    @scanner.skip(/\s+/)
  end

  def read_op
    @scanner.scan(/\.|:|\+|-|\*|\/|%/)
  end

  def read_id
    @scanner.scan(/[_a-zA-Z][_a-zA-Z0-9]*/)
  end

  def read_int
    w = @scanner.scan(/\d+/)
    w.to_i if w
  end

  macro define_nested_reader(name, opening, closing)
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
          return tokens
        else
          @scanner.offset = opening_offset
          error!("Unbalanced {{name}}")
        end
      end
    end
  end

  define_nested_reader(quote, "[", "]")
end
