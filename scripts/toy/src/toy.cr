require "./toy/*"

reader = Toy::Reader.new(ARGV.join(" "))

pp reader.read
