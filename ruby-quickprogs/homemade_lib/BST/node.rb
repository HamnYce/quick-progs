# Frozen_String_Literal: true

# Node for binary search tree
class Node
  include Comparable
  attr_accessor :value, :left, :right

  def initialize(value = nil)
    @value = value
  end

  def <=>(other)
    @value <=> other.value
  end

  def to_s
    @value
  end
end
