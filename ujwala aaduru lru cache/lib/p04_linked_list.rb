class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new()
    @tail = Link.new()
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    if @head.next == @tail
      @head
    else
      @head.next
    end
  end

  def last
    if @tail.prev == @head
      @tail
    else
      @tail.prev
    end
  end

  def empty?
    head_test = @head.next == @tail
    tail_test = @tail.prev == @head
    head_test && tail_test
  end

  def get(key)
    return nil if empty?

    test_node = @head
    until test_node.next.nil?
      test_node = test_node.next
      return test_node.val if test_node.key == key
    end
    nil
  end

  def include?(key)
    return false if empty?

    test_node = @head
    until test_node.next.nil?
      test_node = test_node.next
      return true if test_node.key == key
    end
    false
  end

  def insert(key, val)
    key = Link.new(key,val)
    temp_prev_next = @tail.prev
    @tail.prev = key
    key.next = @tail
    temp_prev_next.next = key
    key.prev = temp_prev_next
  end

  def remove(key)
    return nil if empty?
    # test_node = @head
    # until test_node.next.nil?
    #   test_node = test_node.next
    #   if test_node.key == key
    #     test_node.remove
    #   end
    # end
    # nil
    each do |link|
      if link.key == key
        link.prev.next = link.next
        link.next.prev = link.prev
        link.next = nil
        link.prev = nil
        return link.val
      end
    end
  end

  def each
    return nil if empty?

    test_node = @head
    until test_node.next.val.nil?
      test_node = test_node.next
      yield(test_node)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
