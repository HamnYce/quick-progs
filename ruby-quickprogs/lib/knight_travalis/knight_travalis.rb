# Frozen_String_Literal: true

adjacency_matrix = Array.new(64) do |x|
  Array.new(64) do |y|
    "#{x}, #{y}"
  end
end

p adjacency_matrix[0]

# TODO: construct adjacency matrix with proper connections between squares
#   that knight can move to and fro.

def knight_travels(pos1, pos2); end