class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    total = 0
    self.each_with_index do |el, i|
      if el.is_a?(String)
        total += el.hash*(10**(i))
      elsif el.is_a?(Fixnum)
        total += el.hash*(10**(i))
      end
    end
    total
  end
end

class String
  def hash
    total = 0
    self.split("").each_with_index do |char, i|
      total += (char.ord)*(10**(i))
    end
    total
  end
end

class Hash
  def hash
    total = 0
    self.keys.each_with_index do |el, i|
      if el.is_a?(Fixnum)
        total += el.hash
      elsif el.is_a?(Array)
        total += el.hash
      elsif el.to_s.is_a?(String)
        total += el.hash
      end
    end
    total
  end
end
