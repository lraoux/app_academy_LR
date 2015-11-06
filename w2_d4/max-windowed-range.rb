require_relative "my-stack.rb"
#O(n) because it is window_size * n iterations
def windowed_max_range(arr, w)
  current_max_range = nil

  w.downto(1).each do |ww|
    idx = 0

    while idx <= arr.length - ww

      window = arr[idx..(idx + ww - 1)]
      max = arr[idx + ww - 1]
      min = arr[idx]
      range = max - min

      if current_max_range.nil? || range > current_max_range
        current_max_range = range
      end

      idx += 1
    end
  end

  current_max_range
end

def windowed_max_range2(arr, w)
  current_max_range = nil
  minmaxstack = MinMaxStackQueue.new

  w.times { minmaxstack.enqueue(arr.pop) }

  max = minmaxstack.max
  min = minmaxstack.min

  until arr.empty?
    minmaxstack.dequeue
    minmaxstack.enqueue(arr.pop)

    max = minmaxstack.max
    min = minmaxstack.min
    range = max - min

    if current_max_range.nil? || range > current_max_range
      current_max_range = range
    end
  end

  current_max_range
end

p windowed_max_range2([1, 0, 2, 5, 4, 8], 2) #== 4 # 4, 8
p windowed_max_range2([1, 0, 2, 5, 4, 8], 3) #== 5 # 0, 2, 5
p windowed_max_range2([1, 0, 2, 5, 4, 8], 4) #== 6 # 2, 5, 4, 8
p windowed_max_range2([1, 3, 2, 5, 4, 8], 5) #== 6 # 3, 2, 5, 4, 8
