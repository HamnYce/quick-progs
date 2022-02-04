# Frozen_String_Literal: true

require_relative 'node'

# Ruby implementation of binary search tree
class Tree
  def initialize(arr = nil)
    @root = build_tree(arr)
  end

  # takes an array and produces a balanced binary tree
  def build_tree(arr)
    arr = arr.uniq
    @count = arr.length
    arr = merge_sort(arr)
    @root = build_tree_rec(arr, 0, arr.length - 1)
  end

  # takes a value and inserts it into the tree
  def insert(value)
    @root = insert_rec(@root, value)
  end

  # takes a value and deletes it from the tree
  # if it exists
  def delete(value)
    @root = delete_rec(@root, value)
  end

  # finds and returns the node with the given value
  def find(value)
    find_rec(@root, value)
  end

  # method should traverse in Breadth first and yield
  # each node to the block provided
  # or return an array of values if no blk is given
  def level_order(&blk)
    queue = []
    arr = []
    queue << @root
    until queue.empty?
      node = queue.shift
      block_given? ? yield(node) : arr << node.value
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
    arr
  end

  # recursive version of level_order
  def recursive_level_order(&blk)
    level_order_rec([@root], [], [], &blk)
  end

  # traverse as depth-first as method name and
  # yield to each node to blk provided or
  # return an array of values if no block provided
  def inorder(&blk)
    inorder_rec(@root, [], &blk)
  end

  def preorder(&blk)
    preorder_rec(@root, [], &blk)
  end

  def postorder(&blk)
    postorder_rec(@root, [], &blk)
  end

  # method which accepts a node and returns it's height
  # Height is defined as the number of edges in longest
  # path from a given node to a leaf node.
  # edges from node -> largest path to leaf node
  def height(node)
    height_rec(node, 0)
  end

  # method which accepts a node and return it's depth
  # Depth is defined as the number of edges in path
  # from a given node to the tree’s root node.
  # edges from: root -> node
  def depth(node)
    depth_rec(@root, 0, node)
  end

  # method that checks if the tree is balanced
  # balanced means the height between the left subtree
  # and right subtree is 1 for every node
  def balanced?
    balanced_rec(@root)
  end

  # method that rebalances an unbalaned tree
  # tip (cool one!): use a traversal method to provide
  # a new array to the build_tree method
  def rebalance
    @root = build_tree(inorder)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def build_tree_rec(arr, start, final)
    return if start > final

    middle_index = (final + start) / 2
    middle_value = arr[middle_index]
    root = Node.new(middle_value)
    root.left = build_tree_rec(arr, start, middle_index - 1)
    root.right = build_tree_rec(arr, middle_index + 1, final)
    root
  end

  # produces a new array sorted array using a recursive
  # merge sort method
  def merge_sort(arr)
    return arr if arr.length == 1

    # joining algorithm
    l_arr = merge_sort(arr.take(arr.length / 2))
    r_arr = merge_sort(arr.drop(arr.length / 2))
    merge(l_arr, r_arr)
  end

  def merge(l_arr, r_arr)
    arr = []

    arr << (r_arr[0] >= l_arr[0] ? l_arr.shift : r_arr.shift) until l_arr.empty? || r_arr.empty?

    arr += l_arr if r_arr.empty?
    arr += r_arr if l_arr.empty?
    arr
  end

  def insert_rec(root, value)
    return Node.new(value) if root.nil?

    if value > root.value
      root.right = insert_rec(root.right, value)
    elsif value < root.value
      root.left = insert_rec(root.left, value)
    end
    root
  end

  def delete_rec(root, value)
    return nil if root.nil?

    if value > root.value
      root.right = delete_rec(root.right, value)
    elsif value < root.value
      root.left = delete_rec(root.left, value)
    else
      root = remove_node(root)
    end
    root
  end

  def remove_node(root)
    return if root.left.nil? && root.right.nil?
    return root.left if root.right.nil?
    return root.right if root.left.nil?

    root.value = find_predecessor(root.right)
    root.right = delete_rec(root.right, root.value)
    root
  end

  def find_predecessor(root)
    root = root.left until root.left.nil?
    root.value
  end

  def find_rec(root, value)
    return if root.nil?

    if value > root.value
      find_rec(root.right, value)
    elsif value < root.value
      find_rec(root.left, value)
    else
      root
    end
  end

  def level_order_rec(queue, temp, arr, &blk)
    return arr if queue.empty? && block_given?
    return nil if queue.empty? && !block_given?

    temp << queue.shift until queue.empty?
    temp.each do |node|
      queue << node.left if node.left
      queue << node.right if node.right
      block_given? ? yield(node) : arr << node.value
    end
    level_order_rec(queue, [], arr, &blk)
  end

  def inorder_rec(root, arr, &blk)
    return if root.nil?

    inorder_rec(root.left, arr, &blk)
    block_given? ? yield(root) : arr << root.value
    inorder_rec(root.right, arr, &blk)
    arr
  end

  def preorder_rec(root, arr, &blk)
    return if root.nil?

    block_given? ? yield(root) : arr << root.value
    preorder_rec(root.left, arr, &blk)
    preorder_rec(root.right, arr, &blk)
    arr
  end

  def postorder_rec(root, arr, &blk)
    return if root.nil?

    postorder_rec(root.left, arr, &blk)
    postorder_rec(root.right, arr, &blk)
    block_given? ? yield(root) : arr << root.value
    arr
  end

  def height_rec(node, height)
    return height if node.nil?
    return height unless node.left || node.right

    if node.left && node.right
      [height_rec(node.left, height + 1),
       height_rec(node.right, height + 1)].max
    elsif node.left
      [height_rec(node.left, height + 1), height].max
    else
      [height, height_rec(node.right, height + 1)].max
    end
  end

  def depth_rec(root, depth, node)
    return -1 if root.nil?
    return depth if root == node

    if node > root
      depth_rec(root.right, depth + 1, node)
    elsif node < root
      depth_rec(root.left, depth + 1, node)
    end
  end

  def balanced_rec(root)
    return true if root.nil?

    # I return -1 for empty child when we are finding the height of an empty
    # node we have to go back to it's parent which is a 'negative' edge
    # so to speak
    left_height = (root.left ? height(root.left) : -1)
    right_height = (root.right ? height(root.right) : -1)

    (left_height - right_height).between?(-1, 1) &&
      balanced_rec(root.left) &&
      balanced_rec(root.right)
  end
end
