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

@adjacency_matrix = Array.new(64) do |x|
  valid_moves(x)
end

# IMPORTANT NOTE FOR INDEXES:
# 0,0 top left corner
# 7,0 bottom left corner
# 0,7 top right corner
# 7,7 bottom right corner
def knight_travels(index_start, index_end)
  int_pos_start = index_to_int(index_start)
  int_pos_end = index_to_int(index_end)
  # Distance Hash: {int_position => [distance_from_end, parent_pos]}
  distance_hash = { int_pos_end => [0, nil] }
  int_pos_queue = [int_pos_end]

  # Breath First search and keeping track of distance
  # from the destination using distance_hash to hold parent
  # and distance
  breadth_first_search(int_pos_queue, distance_hash)

  print_parents(int_pos_start, distance_hash)
end

def breadth_first_search(queue, distance_hash)
  distance = 0
  until queue.empty?
    parent_node = queue.shift

    @adjacency_matrix[parent_node].each do |adjacent_node|
      next if distance_hash.key?(adjacent_node) # skip if visited

      # enqeue for BFS
      queue << adjacent_node

      distance_hash[adjacent_node] = [distance + 1, parent_node]
    end
    # increment k as we are getting one layer away from the source
    # with each loop
    distance += 1
  end
end

# using distance Hash to back track starting from start_pos
# and jumping to parent_pos until reaching parent (indicated by 
# nil value for parent_pos)
def print_parents(int_pos_start, distance_hash)
  # Distance Hash: {int_position => [distance_from_end, parent_pos]}
  x = distance_hash[int_pos_start]
  p int_to_index(int_pos_start)
  p int_to_index(x[1])
  until x[0].zero?
    x = distance_hash[x[1]]
    p int_to_index(x[1]) if x[1]
    # child of destination will print destination as parent
  end
end

knight_travels([1, 3], [0, 7])
