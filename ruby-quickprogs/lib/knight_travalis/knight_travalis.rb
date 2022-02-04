# Frozen_String_Literal: true

adjacency_matrix = Array.new(64) do |x|
  Array.new(64) do |y|
    true
  end
end

p adjacency_matrix[0]

# TODO: construct adjacency matrix with proper connections between squares
#   that knight can move to and fro.

# we are representing the squares of the board as integers from 0 - 63
# 0 being 0, 0 (top left corner) and 63 being 7,7 (bottom right corner)
# to go from coordinate ([x][y] indexes) -> integer postion we do
# int_pos = 8*y + x
# to go from integer position -> coordinate we do
# x = integer % 8
# y = integer / 8

# condition for true vs false
# convert from integer position to coordinate
# calculate possible coordinates:
#     if (coordinate is valid)
#       convert to integer and set as true
# repeat for each row

def knight_travels(pos1, pos2); end

# Breadth first search of graph and return the moment you reach
# the required destination (pos2 in knight_travels method)