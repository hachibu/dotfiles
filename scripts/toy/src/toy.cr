require "readline"
require "./toy/syntax/*"

loop do
  next unless input = Readline.readline(">> ", true)
  reader = Toy::Syntax::Reader.new(input)
  if expr = reader.read
    pp expr.value
  end
end
