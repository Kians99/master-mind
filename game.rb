require_relative 'board'

def correct_game_mode?(game_mode)
  if game_mode.casecmp('codebreaker').zero? || game_mode.casecmp('codemaker').zero?
    true
  else 
    puts 'You did not choose a proper game option.'
  end
end

#if true returns true
def int_check?(string_inp)
  count = 0
  p string_inp
  Board::COLORS.each do |colors|
    string_inp.each do |input|
      if colors.casecmp(input) == 0
        count += 1
      end
    end
  end
  p count
  return count == 4

end

def proper_col_inp?(colors)
  if !colors.index(',').nil? && int_check?(colors.split',')
    true
  else
    puts "You did not enter a valid guess!"
  end
end

def main(game_mode)
    board = Board.new
    if game_mode.casecmp('codebreaker').zero?

      puts "Beep Boop Bop. The computer has thought of the four-length hidden\ncolor code. Yellow, White, Black, Brown, Orange, Red, Green, and Blue are all options for guessing. Please enter your coordinates comma seperated like:\n\"Red,Green,Blue,Orange\" GoodLuck!"
      
      until board.is_game_over?
        color_inp = gets.chomp
        p color_inp
        if proper_col_inp?(color_inp)
          arr_colors = color_inp.split(',')
          p arr_colors
          p "WOOHOO"
        end



      end

    else
      
    end
    
end

puts 'Hello! Welcome to Mastermind. Would you like to be the codebreaker
or the codemaker? Type "codebreaker" or "codemaker" below'
maker_breaker = gets.chomp
if correct_game_mode?(maker_breaker)
  main(maker_breaker)
end
