class Mastermind
  @@player_score = 0
  @@computer_score = 0
  @@turn_number = 0

  def initialize
    @player_creator = 0
    @gameboard = create_board
  end

  def create_board
    @gameboard = Array.new(12).map do |x|
      x = "- - - -"
    end
  end

  def puts_board
    @gameboard.each_index do |index|
      if @@turn_number == (index + 1)
        @gameboard[index] = @four_values.to_s.delete('^0-9 " "') + @guess_key
        puts @gameboard[key]
      else
        puts @gameboard[index]
      end
    end
  end

  def turn_over
    if @player_creator == true && @player_code == computer_guess
      puts "Code Creator has #{player_score} points"
    end
  end
end


class Computer

  def initialize
    @computer_guess = [1, 1, 2, 2]
    @computer_code = create_random_code
    @code_combinations = generate_potential_guesses
  end


  def generate_potential_guesses
    (1111..6666).to_a.map do |x|
      x.digits.reverse
    end
  end

  def create_random_code
    computer_code = code_combinations.sample
  end

  def generate_guess
    if @@turn_number == 1
      @computer_guess = @computer_guess
    elsif @@turn_number > 1
      @code_combinations = @code_combinations.map do |x|
        x.each do |x|
          if(x[0] == @computer_guess[0] || x[1] == @computere_guess[1] ||
            x[2] == @computer_guess[2] || x[3] == @computer_guess[3])
            x
          else
            @computer_guess.combinations(@value_only).each do |y|
            if x.difference(y) < (x.length - @value_only) then x
            end
          end
          end
        end
      end
    end
  end
end

class Player
  def initialize
    @player_guess = get_four_values
    @player_code = get_four_values
  end

  def get_player_role
    @player_creator = 0
    puts "Please enter 'code guesser' or 'code creator'"
    @player_response = gets.downcase.chomp
    unless @player_response == 'code guesser' || @player_response == 'code creator'
      get_player_role
    end
  end

  def assign_player_role
    if @player_response == "code guesser"
      @player_creator = false
    elsif @player_response == "code creator"
      @player_creator = true
    end
  end
end

  def get_four_values
    puts "please enter 4 numbers between 1 and 6"
    @four_values = gets.chomp.gsub(/\s+/, "").split("").map { |x| x.to_i }
  end