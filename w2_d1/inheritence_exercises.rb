class Employee
  attr_reader :salary

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  def initialize(name, title, salary, boss, employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    count = 0
    @employees.each do |el|
      count += el.salary
    end
    count * multiplier
  end

end

#random selections from memory puzzle to try begin/rescue
#raise in one function and have begin/rescue in the function that is calling the other
def reveal(pos)
  if revealed?(pos)
    raise RevealedError
  rescue RevealedError => e
     puts "You can't flip a card that has already been revealed."
     puts "Error was: #{e.message}"
  else
    self[pos].reveal
  end
  self[pos].value
end

class RevealedError < StandardError
end
----------------
def play
  until board.won?
    board.render
    begin
      pos = get_player_input
      raise InputError
    rescue
      "Invalid input"
      retry
    end
    make_guess(pos)
  end

  puts "Congratulations, you win!"
end

class InputError < StandardError
end
--------------

def get_player_input
  pos = nil
  begin
  pos && valid_pos?(pos)
    raise ValidpError if valid_pos? == false
  rescue ValidpError
    puts "Invalid position"
    retry
  end
    pos = player.get_input
  end

  pos
end

class ValidpError < StandardError
end
