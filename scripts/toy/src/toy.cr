require "./toy/syntax/*"

reader = Toy::Syntax::Reader.new(ARGV.join(" "))

pp reader.read
