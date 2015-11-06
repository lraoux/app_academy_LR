require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    num = key.hash
    @store[num % num_buckets].include?(key)
  end

  def set(key, val)
    num = key.hash
    if count < num_buckets
      @store[num % num_buckets].insert(key, val)
    else
      resize!
      @store[num % num_buckets].insert(key, val)
    end
    @count += 1
  end

  def get(key)
    num = key.hash
    @store[num % num_buckets].get(key)
  end

  def delete(key)
    num = key.hash
    @store[num % num_buckets].remove(key)
    @count -= 1
  end

  def each
    @store.each do |bucket|
      bucket.each do |link|
        unless link.nil?
          yield [link.key, link.val]
        end
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { LinkedList.new }
    if count == num_buckets
      @store.each do |bucket|
        bucket.each do |link|
          set(link.key, link.val)
        end
      end
    end

    @store = new_store
    @count = 0
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
