require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets

    unless self[key].include?(key)
      @count += 1
      self[key] << key
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_store = @store.dup.flatten
    if @count == num_buckets
      @store = Array.new(num_buckets * 2) { Array.new }
      @count =0
      temp_store.each  do |element|
        insert(element)
      end
    end
  end
end
