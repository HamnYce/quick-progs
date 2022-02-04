# Frozen_String_Literal: true

# we are representing the squares of the board as integers from 0 - 63
# in the adjacency matrix

# 0 being 0, 0 (top left corner) and 63 being 7,7 (bottom right corner)
# second row first column is 8
# to go from index coordinate -> integer postion we do
# int_pos = 8*x + y
# e.g. index [3][2] (4th row, 3rd column) 8*3 + 2 = 26
# to go from integer position -> index [x][y] we do
# x = integer / 8
# y = integer % 8
# e.g. 26, x = 26 / 8 = 3, y = 26 % 8 = 2, [3][2]

# condition for true vs false
# convert from integer position to coordinate
# calculate possible coordinates:
#     if (coordinate is valid)
#       convert to integer and set as true
# repeat for each row

require_relative 'knight_node'

def int_to_index(int_pos)
  [int_pos / 8, int_pos % 8]
end

def index_to_int(coord)
  (8 * coord[0]) + coord[1]
end

def valid_moves(int_pos)
  start_coord = int_to_index(int_pos)
  valid_move_arr = []
  modifier_arr = [[1, 2], [1, -2], [-1, 2], [-1, -2],
                  [2, 1], [2, -1], [-2, 1], [-2, -1]]

  modifier_arr.each do |modifier|
    move = [start_coord[0] + modifier[0],
            start_coord[1] + modifier[1]]
    valid_move_arr << index_to_int(move) if valid_move?(move)
  end
  valid_move_arr
end

def valid_move?(arr)
  arr[0].between?(0, 7) && arr[1].between?(0, 7)
end

def cartesian_to_index(cart_coord)
  cart_coord.reverse
end

# Breadth first search of graph and return the moment you reach
# the required destination (pos2 in knight_travels method)

adjacency_matrix = Array.new(64) do |x|
  valid_moves(x)
end

def knight_travels(index_start, index_end, adj_matrix)
  k = 0
  int_pos_start = index_to_int(index_start)
  int_pos_end = index_to_int(index_end)
  # int_pos => [distance_from end, parent]
  distance_hash = { int_pos_end => [0, nil] }
  int_pos_queue = [int_pos_end]

  until int_pos_queue.empty?
    curr = int_pos_queue.shift

    adj_matrix[curr].each do |pos|
      next if distance_hash.key?(pos)

      int_pos_queue << pos
      distance_hash[pos] = [k + 1, curr]
    end

    k += 1
  end
  # TODO: backtrack from start to end and print all indeces
  # FIXME: distance_hahs is not populating properly
  x = distance_hash[int_pos_start]
  p int_to_index(int_pos_start)
  p int_to_index(x[1])
  until x[0].zero?
    x = distance_hash[x[1]]
    p int_to_index(x[1]) if x[1]
    # child of destination will print destination as parent
  end
end

knight_travels([1, 3], [0, 7], adjacency_matrix)
