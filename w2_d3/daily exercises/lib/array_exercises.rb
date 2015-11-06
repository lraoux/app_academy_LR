class Array
  def my_uniq
    result = []
    self.each do |num|
      result << num unless result.include?(num)
    end
    result
  end

  def two_sum
    result = []
    self.each_with_index do |n,idx|
      self.each_with_index do |n2,idx2|
        next if idx >= idx2
        result << [idx,idx2] if n + n2 == 0
      end
    end
    result
  end
end

def my_transpose(arr)
  result = Array.new(arr.length) {[]}
  arr.each_with_index do |row, i|
    row.each_with_index do |num, j|
      result[i][j] = arr[j][i]
    end
  end
  result
end

def stock_picker(arr)
  result = 0
  difference = arr.min
  arr.each_with_index do |n,idx|
    arr.each_with_index do |n2,idx2|
      next if idx >= idx2
      if (n2 - n) > difference
        result = [idx,idx2]
        difference = (n2 - n)
      end
    end
  end
  result
end

class TowersOfHanoi
    attr_reader :stacks

    def initialize(stacks = [[3,2,1],[],[]])
      @stacks = stacks
    end

    def move(arr)
      @stacks[arr[1]] << @stacks[arr[0]].pop
    end

    def over?
      stacks[0].empty? && (stacks[1].empty? || stacks[2].empty?)
    end

    def play
      until over?
        puts "Please provide a stack to pick from and to put to. Ex. 1,2"
        input = gets.chomp.split(",")
        #"1,2"
        move([input[0].to_i,input[1].to_i])
      end
      puts "YOU WIN! YOU'RE SO AWESOME."
    end


end
