class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    current = @head
    until current.next == nil
      current = current.next
    end
    current
  end

  def empty?
    @head.nil?
  end

  def get(key)
    current = @head
    until current.key == key
      return nil if current.next == nil
      current = current.next
    end
    current.val
  end

  def include?(key)
    current = @head
    until current.next == nil
      return true if current.key == key
      current = current.next
    end
    false
  end

  def insert(key, val)
    # new_head = Link.new(key, val)
    # new_head.next = @head
    # @head = new_head
    new_tail = Link.new(key, val)
    current = @head
    until current.next == nil
      current = current.next
    end
    current.next = new_tail

  end

  def remove(key)
    current = @head
    if current.key == key
      @head = current.next
    else
      until current.next.key == key
        current = current.next
      end
      current.next = current.next.next
    end

  end

  def each(&prc)
    current = @head.next
    until current.next == nil
      prc.call(current)
      current = current.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
