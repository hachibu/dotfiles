require "colorize"
require "readline"
require "./syntax/*"

class Toy::Interpreter
  def start
    loop do
      next unless input = Readline.readline(">> ", true)
      next unless expr = Toy::Syntax::Reader.new(input).read
      pp expr.value
    rescue error
      puts error.colorize.red
    end
  end
end
