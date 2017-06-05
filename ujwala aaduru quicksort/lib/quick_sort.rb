class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]
    left = []
    right = []

    left =  array.select do |el|
              el < pivot
            end
    right = array.select do |el|
              el > pivot
            end

    sort1(left) + [pivot] + sort1(right)

  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 1
    prc ||= Proc.new { |el, el2| el <=> el2 }

    # pivot = array[start]
    pivot_index = partition(array, start, length, &prc)

    left = pivot_index - start
    right  = length - (left + 1 )

    sort2!(array, start, left, & prc)
    sort2!(array, pivot_index+1, right, & prc)
    array

  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el, el2| el <=> el2 }

    pivot = array[start]
    ending_idx = start + length
    new_start = start + 1
    pivot_index =start

    (new_start...ending_idx).each do |idx|
      val = array[idx]
      if prc.call(pivot, array[idx] ) < 1
      else
        array[idx], array[pivot_index+1] = array[pivot_index+1], pivot
        array[pivot_index] = array[idx]
        array[pivot_index] = val
        pivot_index = pivot_index + 1

      end
    end
    pivot_index

  end
end
