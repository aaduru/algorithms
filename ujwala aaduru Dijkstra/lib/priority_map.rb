require_relative 'heap2'

class PriorityMap
  def initialize(&prc)
    @map = {}
    @queue = BinaryMinHeap.new() do |key1, key2|
      prc.call(@map[key1], @map[key2])
    end
  end

  def [](key)
    @map[key]
  end

  def []=(key, value)
    if @map.has_key?(key)
      update(key,value)
    else
      insert(key,value)
    end
  end

  def count
    self.map.count
  end

  def empty?
    count == 0
  end

  def extract
    vertex = @queue.extract
    cost = @map.delete(vertex)
    [vertex, cost]
  end

  def has_key?(key)
    @map.has_key?(key)
  end

  protected
  attr_accessor :map, :queue

  def insert(key, value)
    @map[key] = value
    @queue.push(key)

  end

  def update(key, value)
    @map[key] = value
    @queue.reduce!(key)
  end
end
