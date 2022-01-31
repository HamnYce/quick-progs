# Frozen_String_Literal: true

# Node for linked list
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil)
    @value = value
    @next_node = nil
  end
end

# LinkedList Data Structure
class LinkedList
  attr_reader :head, :tail, :length

  def initialize
    @head = nil
    @tail = nil
    @length = 0
  end

  # adds a new node containing value to the end of the list
  def append(value)
    if empty?
      @head = @tail = Node.new(value)
    elsif size == 1
      @head.next_node = @tail = Node.new(value)
    else
      @tail = @tail.next_node = Node.new(value)
    end
    @length += 1
    value
  end

  # adds a new node containing value to the start of the list 
  def prepend(value)
    @head = @tail = Node.new(value) if empty?
    temp = Node.new(value)
    temp.next_node = @head
    @head = temp
    @length += 1
  end

  # returns the total number of nodes in the list
  def size
    @length
  end

  # returns the node at the given index
  def at(index)
    return if index >= @length

    curr = @head
    index.times.each { curr = curr.next_node }
    curr.value
  end

  # removes the last element from the list
  def pop
    return if empty?
    @head = @tail = nil or return if size == 1

    curr = @head
    (size - 2).times.each { curr = curr.next_node }
    curr.next_node = nil
    @length -= 1
    @tail = curr
  end

  # returns true if the passed in value is in the list and otherwise returns
  # false.
  def contains?(value)
    return true if @head.value == value

    curr = @head
    (size - 1).times.each do |_i|
      curr = curr.next_node
      return true if curr.value == value
    end
    false
  end

  # returns the index of the node containing value, or nil if not found.
  def find(value)
    return 0 if @head.value == value

    curr = @head
    (size - 1).times.each do |i|
      curr = curr.next_node
      return i + 1 if curr.value == value
    end
    nil
  end

  # represent your LinkedList objects as strings, so you can print them out and
  # preview them in the console.
  # The format should be: ( value ) -> ( value ) -> ( value ) -> nil
  def to_s; end

  # that inserts a new node with the provided value at the given index.
  def insert_at(value, index); end

  # that removes the node at the given index.
  def remove_at(value); end

  private

  def empty?
    size.zero?
  end
end

def test
  return
end
