

def lcs_table(str1, str2)
  # Create your DP matrix in here.
  matrix = Array.new(str1.length){ Array.new(str2.length) {0} }

  str1.split("").each_with_index do |c1, i1|
    str2.split("").each_with_index do |c2, i2|
      if c1 == c2
        if i1 == 0 || i2 == 0
          matrix[i1][i2] += 1
        else
          matrix[i1][i2] = matrix[i1 - 1][i2 - 1] + 1
        end
      else
        matrix[i1][i2] = [matrix[i1-1][i2],matrix[i1][i2-1]].max
      end
    end
  end

  matrix
end

def lcs_length(str1, str2)
  lcs_table(str1,str2).last.last #<== This will select the bottom right cell of your DP matrix, which should be the longest subsequence length
end

def lcs(str1, str2)
  # actually generate the LCS! Work backwards from your DP matrix.
  matrix = lcs_table(str1, str2)
  length = lcs_length(str1, str2)

  result_string = ""
  row = str1.length - 1
  col = str2.length - 1

  until length == 0
    top = matrix[row-1][col]
    left = matrix[row][col-1]
    diag = matrix[row-1][col-1]

    if length == top
      row -= 1
    elsif length == left
      col -= 1
    else
      length -= 1
      result_string += str1[row]
      row -= 1
      col -= 1
    end
  end

  result_string.reverse
end

EDIT_COSTS = {
  replace: 1,
  insert: 1,
  delete: 1,
}

def lev_table(str1, str2)
  # Create your DP matrix in here.
  matrix = Array.new(str1.length+1){ Array.new(str2.length+1) {0} }

  matrix.first.map!.with_index{|_,i| i }

  matrix = matrix.transpose
  matrix.first.map!.with_index{|_,i| i }
  matrix = matrix.transpose

  ("_"+str1).split("").each_with_index do |c1, i1|
    ("_"+str2).split("").each_with_index do |c2, i2|
      next i1 == 0 || i2 == 0
      top = matrix[i1-1][i2]
      left = matrix[i1][i2-1]
      diag = matrix[i1-1][i2-1]

      if c1 == c2
        matrix[i1][i2] = diag
      else
        matrix[i1][i2] = [top,left,diag].min + 1
      end
    end
  end

  matrix
end

def edit_distance(str1, str2)
  costs = EDIT_COSTS
  # Figure out the Levenshtein distance between these two strings!
  matrix = lcs_table(str1, str2)
  p matrix
  matrix.last.last


end

def autocorrect(str)
  File.foreach("dictionary.txt") { |line| nil }
  # Do stuff in here to create your autocorrect method! I've given you a dictionary.
end
