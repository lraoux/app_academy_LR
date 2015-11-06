class MaxIntSet
  attr_reader :max
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num % max] = true
  end

  def remove(num)
    validate!(num)
    @store[num % max] = false
  end

  def include?(num)
    validate!(num)
    @store[num % max]
  end

  private

  def is_valid?(num)
    if num < max && num > 0
      return true
    else
      return false
    end

  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] << num
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].each do |el|
      if el == num
        return true
      end
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if count < num_buckets
      @store[num % num_buckets] << num
    else
      resize!
      @store[num % num_buckets] << num
    end
    @count += 1
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].each do |el|
      if el == num
        return true
      end
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
#do this to not have collisions in the bucket
  def resize!
    new_store = Array.new(num_buckets * 2){Array.new}
    if count == num_buckets
      @store.each do |bucket|
        bucket.each do |el|
          new_store[el % num_buckets] << el
        end
      end
    end
    @store = new_store 
  end
end
