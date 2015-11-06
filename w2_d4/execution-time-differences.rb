#phase1
#(n-1) comparisons * n = O(n^2) complexity
def my_min(arr)
   arr.each do |i|
    larger = []
    arr.each do |j|
      larger << j if i < j
    end
    return i if larger.length == arr.length-1
  end
end

#phase 2
#O(n) complexity
def my_min(arr)
  smallest = arr.first
  arr.each do |i|
    if i < smallest
      smallest = i
    end
  end
  smallest
end

#phase 1
# n^2 + n = O(n^2)
def largest_contiguous_subsum(arr)
  sub_arrs = []
  arr.each_index do |i|
    arr.drop(i).each do |j|
      sub_arrs << arr[i..j]
    end
  end

  sums = []
  sub_arrs.each do |sub_arr|
    sums << sub_arrs.inject(&:+)
  end

  sums.max
end

#phase2
#
def largest_contiguous_subsum(arr)
  best_sum = 0 # 1
  current_sum = 0 # 2
  arr.each do |i| # n (=> n)
    current_sum = 0 if i > (i + current_sum)
    current_sum += i # 1
    best_sum = current_sum if current_sum > best_sum # 2
  end
  best_sum # 0
end

p largest_contiguous_subsum([-2, -3, 5])
p largest_contiguous_subsum([5, 3, -4, 7])
