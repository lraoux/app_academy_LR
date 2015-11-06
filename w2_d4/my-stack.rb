require "byebug"

class MyStack
  attr_reader :max, :min

  def initialize
    @store = []
    @min = nil
    @max = nil
  end

  def pop
    el = @store.pop

    if peek.nil?
      @max = nil
      @min = nil
    else
      @max = peek[:max]
      @min = peek[:min]
    end

    el
  end

  def push(el)
    @min = el if min.nil? || el < min
    @max = el if max.nil? || el > max
    @store.push({value: el, max: max, min: min})
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

end

class MinMaxStackQueue
  def initialize()
    @in_stack = MyStack.new()
    @out_stack = MyStack.new()
  end

  def enqueue(el)
    @in_stack.push(el)
  end

  def dequeue
    flip if @out_stack.size.zero?
    @out_stack.pop
  end

  def flip
    until @in_stack.size.zero?
      @out_stack.push(@in_stack.pop[:value])
    end
  end

  def peek
    @out_stack.peek
  end

  def size
    @in_stack.size + @out_stack.size
  end

  def min
    # if @out_stack.min.nil? || @in_stack.min < @out_stack.min
    #   @in_stack.min
    # else
    #   @out_stack.min
    # end
    flip
    @out_stack.min
  end

  def max
    # if @out_stack.max.nil? || @in_stack.max > @out_stack.max
    #   @in_stack.max
    # else
    #   @out_stack.max
    # end
    flip
    @out_stack.max
  end

end
