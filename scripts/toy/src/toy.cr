require "./toy/syntax/*"

reader = Toy::Syntax::Reader.new(ARGV.join(" "))

reader.read.pretty_print
