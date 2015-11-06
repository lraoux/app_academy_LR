#O(n^2)
def bad_two_sum?(arr, target_sum)
  arr.each_index do |i|
    arr.each_index do |j|
      next if i == j
      return true if (arr[i] + arr[j]) == target_sum
    end
  end
  false
end

#O(nlog(n)) because binary_search is O(log(n))
def okay_two_sum?(arr, target_sum)
  arr.sort!

  arr.each_with_index do |el, idx|
    target_value = target_sum - el
    return true if binary_search(arr[0...idx] + arr[idx + 1..-1], target_value)
  end

  false
end

def binary_search(arr, target)
  if arr.length == 1
    if arr.first == target
      return true
    else
      return false
    end
  end

  mid_point = arr.length / 2
  mid_value = arr[mid_point]

  if target < mid_value
    binary_search(arr.take(mid_point), target)
  elsif target > mid_value
    binary_search(arr.drop(mid_point), target)
  else
    return true
  end
end

#O(n) complexity
def two_sum?(arr, target)
  hash = {}
  arr.each do |el|
    target_value = target - el
    return true if hash.has_key?(target_value)
    hash[el] = true
  end

  false
end
