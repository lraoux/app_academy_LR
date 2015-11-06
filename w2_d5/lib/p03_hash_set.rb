require_relative 'p02_hashing'

class HashSet
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
    if count < num_buckets
      @store[num % num_buckets] << key
    else
      resize!
      @store[num % num_buckets] << key
    end
    @count += 1
  end

  def include?(key)
    num = key.hash
    @store[num % num_buckets].each do |el|
      if el.key == key
        return true
      end
    end
    false
  end

  def remove(key)
    num = key.hash
    @store[num % num_buckets].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!

    new_store = Array.new(num_buckets * 2){ Array.new }
    if count == num_buckets
      @store.each do |bucket|
        bucket.each do |el|
          new_store[el.hash % num_buckets] << el
        end
      end
    end

    @store = new_store

  end
end
