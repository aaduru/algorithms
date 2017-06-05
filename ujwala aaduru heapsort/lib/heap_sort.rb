require_relative "heap"

class Array
  def heap_sort!
    2.upto(count).each do |el|
      BinaryMinHeap.heapify_up(self, el - 1, el)
    end

    count.downto(2).each do |el|
      self[el - 1], self[0] = self[0], self[el - 1]
      BinaryMinHeap.heapify_down(self, 0, el - 1)
    end

    self.reverse!
  end
end
