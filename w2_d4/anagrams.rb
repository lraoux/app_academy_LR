#0(n!)
def first_anagram(string_one, string_two)

  possible_anagrams = [string_one]
  while possible_anagrams.length < string_one.length.downto(1).inject(:*)
    current_anagram = possible_anagrams.last.dup
    current_anagram.split('').drop(1).each_index do |idx|
      letter = current_anagram[0]
      new_anagram = current_anagram[1..-1].dup
      new_anagram.insert(idx + 1, letter)
      possible_anagrams << new_anagram
    end
  end
  possible_anagrams.include?(string_two)
end

#this one is O(n^2)
def second_anagram(string_one, string_two)
  string_one_dup = string_one.dup
  string_two_dup = string_two.dup
  string_one.each_char do |char1|
    string_two.each_char do |char2|
      if char1 == char2
        string_one_dup.sub!(char1, "")
        string_two_dup.sub!(char2, "")
      end
    end
  end
  string_one_dup.empty? && string_two_dup.empty?
end

# O(nlog(n)) based on ruby's sort function
def third_anagram(string_one, string_two)
  string_one.split("").sort == string_two.split("").sort
end

def fourth_anagram(string_one, string_two)
  hash_one = Hash.new(0)
  hash_two = Hash.new(0)

  string_one.each_char do |c|
    hash_one[c] += 1
  end

  string_two.each_char do |x|
    hash_two[x] += 1
  end

  hash_one == hash_two
end









# def anagrams(string)
#   return [string] if string.length <= 1
#
#   prev_anagrams = anagrams(string[0...-1])
#   next_letter = string[-1]
#
#   next_anagrams = []
#   prev_anagrams.each do |ana|
#     (0..ana.length).each do |i|
#       next_anagrams << ana[0...i] + next_letter + ana[i..-1]
#     end
#   end
#
#   next_anagrams
# end
