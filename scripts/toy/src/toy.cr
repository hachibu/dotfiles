require "./toy/syntax/*"

reader = Toy::Syntax::Reader.new(ARGV.join(" "))
expr = reader.read

expr.pretty_print
