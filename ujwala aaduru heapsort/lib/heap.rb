class BinaryMinHeap

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    raise "no element to extract" if count == 0
    val = @store[0]

    if count > 1
      store[0] = store.pop
      self.class.heapify_down(@store, 0, &prc)
    else
      store.pop
    end
    val
  end

  def peek
    raise "no element to peek" if count == 0
    @store[0]
  end

  def push(val)
    @store << val
    self.class.heapify_up(@store, self.count - 1, &prc)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    child_idx_1 = 2 * parent_index + 1
    child_idx_2 = 2 * parent_index + 2
    [child_idx_1, child_idx_2].select do |child_index|
      child_index < len
    end
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    parent_node = (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    child1, child2 = child_indices(len, parent_idx)

    parent = array[parent_idx]

    child_array = []
    child_array << array[child1] if child1
    child_array << array[child2] if child2

    if child_array.all? { |child| prc.call(parent, child) <= 0 }

      return array
    end


    new_idx = nil
    if child_array.length == 1
      new_idx = child1
    else
      new_idx =
        prc.call(child_array[0], child_array[1]) == -1 ? child1 : child2
    end

    array[parent_idx], array[new_idx] = array[new_idx], parent
    heapify_down(array, new_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    if child_idx == 0
      return array
    end
    parent_idx = parent_index(child_idx)
    child_val = array[child_idx]
    parent_val = array[parent_idx]
    if prc.call(child_val, parent_val) >= 0
     return array
    else
     array[child_idx], array[parent_idx] = parent_val, child_val
     heapify_up(array, parent_idx, len, &prc)
   end
  end
end
