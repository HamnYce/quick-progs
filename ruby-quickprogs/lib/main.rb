# Frozen_String_Literal: true

def palindrome?(num)
  num.digits == num.digits.reverse
end

def pal(x, y, total)
  return x * y if palindrome?(x * y)
end

puts pal(1000, 1000, 1_000_000)
