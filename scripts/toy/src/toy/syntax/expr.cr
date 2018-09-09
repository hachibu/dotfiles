require "colorize"

module Toy::Syntax
  class Expr
    property value

    def pretty_print(level = 0)
      indent = "    " * level
      o_paren = "(".colorize.cyan
      c_paren = ")".colorize.cyan
      o_bracket = "[".colorize.green
      c_bracket = "]".colorize.green
      e_class = self.class.to_s.sub("Toy::Syntax::", "").colorize.yellow
      e_value_color = :magenta

      print "#{indent}#{o_paren}#{e_class} "
      case self
      when Toy::Syntax::Identifier
        puts "#{self.value.colorize(e_value_color)}#{c_paren}"
      when Toy::Syntax::Integer
        puts "#{self.value.colorize(e_value_color)}#{c_paren}"
      when Toy::Syntax::Operator
        puts "#{self.value.colorize(e_value_color)}#{c_paren}"
      when Toy::Syntax::Quote
        puts o_bracket
        self.value.each { |e| e.pretty_print(level + 1) }
        puts "#{indent}#{c_bracket}#{c_paren}"
      end
    end
  end

  class Identifier < Expr
    def initialize(@value : String); end
  end

  class Integer < Expr
    def initialize(@value : Int32); end
  end

  class Operator < Expr
    def initialize(@value : String); end
  end

  class Quote < Expr
    def initialize(@value : Array(Expr)); end
  end
end
