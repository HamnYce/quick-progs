# Frozen_String_Literal: true

def palindrome?(num)
  num.digits == num.digits.reverse
end

def pal(x, y)
  puts "x:#{x} y:#{y}" or return x * y if palindrome?(x * y)

  if y < 100
    pal(x - 1, 999)
  else
    pal(x, y - 1)
  end
end

puts pal(999, 999)
