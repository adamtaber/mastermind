class Mastermind
  def initialize
    @player_creator = 0
    @player_role = 0
    @four_values = 0
    @guess_value = 0
    @guess_key = 0
    @code_value = 0
    @turn_number = 0
    @player_score = 0
    @computer_score = 0
    @gameboard = create_board
    @value_only = 0
    @value_location = 0
    @value_location_comp = 0
    @round_over = false
    @potential_combinations = 0
    @new_combinations = []
    @permutations = []
  end

  def create_board
    @gameboard = Array.new(12).map do |x|
      x = "- - - -"
    end
  end

  def puts_board
    @gameboard.each_index do |index|
      if @turn_number == (index + 1)
        @gameboard[index] = @guess_value.to_s.delete('^0-9 " "') + '    ' + @guess_key
        puts @gameboard[index]
      else
        puts @gameboard[index]
      end
    end
    puts "-------------------------------------------------------------"
  end

  def play_mastermind
    puts 'Welcome to Mastermind'
    puts 'Please type "code creator" or "code guesser"'
    @player_role = gets.chomp.downcase
    assign_role
    play_round
  end

  def assign_role
    case @player_role
    when 'code creator'
      @player_creator = true
    when 'code guesser'
      @player_creator = false
    else
      puts 'please type code creator or code guesser'
      @player_role = gets.chomp.downcase
      assign_role
    end
  end

  def play_round
    if @player_creator == true
      get_four_values
      @code_value = @four_values
      until @round_over == true
        play_computer_guess
      end
      puts "The round is over. You have #{@player_score} points, I have #{@computer_score} points"
      @player_creator = false
      @turn_number = 0
      @round_over = false
      @potential_combinations = generate_potential_guesses
    end
  end

  def play_computer_guess
    @turn_number += 1
    @player_score += 1
    get_computer_guess
    winner?
  end

  def get_four_values
    puts "Please enter four values between 1 and 6. This will be your code"
    @four_values = gets.chomp.gsub(/\s+/, '').split('').map(&:to_i)
  end

  def get_computer_guess
    if @turn_number == 1
      generate_potential_guesses
      @guess_value = [1, 1, 2, 2]
      get_guess_key
      puts_board
    else
#      generate_permutations
#      @permutations
      generate_new_combinations
      @guess_value = @new_combinations.min
      get_guess_key
      puts_board
      @potential_combinations = @new_combinations
      @new_combinations = []
    end
  end

  def generate_potential_guesses
    @potential_combinations = (1111..6666).to_a
    @potential_combinations = @potential_combinations.map! do |x|
      x.digits.reverse
    end
    @potential_combinations.map do |x|
      if x.include?(0)
        @potential_combinations.delete(x)
      end
    end
  end

  def winner?
    if @guess_value == @code_value
      @round_over = true
    elsif @turn_number == 12
      @round_over = true
    end
  end


  def get_guess_key
    @value_only = 0
    @value_location = 0
    for i in 1..6
      if @guess_value.count(i) >= @code_value.count(i)
        @value_only += @code_value.count(i)
      else @value_only += @guess_value.count(i)
      end
    end
    @guess_value.each_index do |index|
      if @guess_value[index] == @code_value[index]
        @value_location += 1
      end
    end
    @value_only -= @value_location
    @guess_key = "Correct value & location: #{@value_location}. Correct value only: #{@value_only}"
  end

  def generate_new_combinations
    find_exact_match
#    find_perm_inclusions
    @new_combinations = @new_combinations.uniq.sort!
  end

  def find_exact_match
    @potential_combinations.each do |combination|
      combination.each_index do |index|
        if @value_location == 0 && (combination[index] == @guess_value[index])
          @value_location_comp += 1
        elsif (@value_location > 0) && (combination[index] == @guess_value[index])
          @value_location_comp += 1
        end
      end
      if (@value_location == 0) && (@value_location_comp == 0)
        @new_combinations.push(combination)
      elsif (@value_location_comp == @value_location) && (@value_location != 0)
        @new_combinations.push(combination)
      end
      @value_location_comp = 0
    end
  end
end

#  def find_perm_inclusions
#    @potential_combinations.each do |combination|
#      if @value_only == 0 && combination.difference(@guess_value).length == 4
#        @new_combinations.push(combination)
#      else
#        for i in 1..6
#          if (@guess_value.count(i) > @value_only) && (combination.count(i) <= @value_only)
#            @new_combinations.push(combination)
#          elsif (@guess_value.count(i) <= @value_only) && (combination.count(i) >= @guess_value.count(i))
#            @new_combinations.push(combination)
#          end
#        end
#      end
#    end





#    @potential_combinations.each do |combination|
#      @permutations.each do |permutation|
#        if combination.join.include?(permutation.join)
#          @new_combinations.push(combination)
#        end
#      end
#    end
#  end
  

#  def generate_permutations
#    @guess_value.permutation(@value_only) do |x|
#      @permutations.push(x)
#    end
#   @permutations.uniq!
#  end
        


Mastermind.new.play_mastermind
