class String
  def XOR(other_binary_string)
    bits = self.split("")
    xor_string = ""

    bits.each_with_index do |bit, idx|
      if other_binary_string[idx] == bit
        xor_string += "0"
      else
        xor_string += "1"
      end
    end

    xor_string
  end

  def LSHIFT(num)
    self[num..-1] + ("0"*num)
  end
end

def power_of_two(num)
  binary_string = num.to_s(2)
  binary_string.reverse.index("1") == binary_string.length-1
end

def swap(x,y)
  x = x.to_s(2).XOR(y.to_s(2)).XOR(x.to_s(2))
  y  = x.to_s(2).XOR(y.to_s(2)).XOR(x.to_s(2))

  puts "#{x}, #{y}"
end

swap(1,2)
