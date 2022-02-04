#Frozen_String_Literal: true

# Knight class with attributes to help with BFS
class KnightNode
  attr_accessor :value, :distance, :parent

  def initialize(value)
    @value = value
  end

  def to_s
    "value: #{@value}, distance from root:#{@distance}, parent:#{@parent}\n"
  end
end
