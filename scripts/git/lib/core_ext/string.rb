class String
  COLORS = {
    green: 32,
    red: 31,
    yellow: 33
  }

  COLORS.each do |k, v|
    define_method(k) { "\033[#{v}m#{self}\033[0m" }
  end
end
