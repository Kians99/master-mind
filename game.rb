require_relative 'board'

def correct_game_mode?(game_mode)
  if game_mode.casecmp('codebreaker').zero? || game_mode.casecmp('codemaker').zero?
    true
  else 
    puts 'You did not choose a proper game option.'
  end
end

def lower_case(raw_input)
  raw_input.map { |col| col.downcase }
end

def color_check?(string_inp)
  count = 0
  Board::COLORS.each do |colors|
    string_inp.each do |input|
      count += 1 if colors.casecmp(input).zero?
    end
  end
  count == 4
end

def proper_col_inp?(colors)
  !colors.index(',').nil? && color_check?(colors.split(','))
end

def main(game_mode)
    board = Board.new
    if game_mode.casecmp('codebreaker').zero?
      puts "—————————————————————————————————————————————————\nBeep Boop Bop.
The computer has thought of the four-length hidden color code. Yellow, White, Black, 
Brown, Orange, Red, Green, and Blue are all options for guessing. Please enter your
coordinates comma seperated like:\n\"Red,Green,Blue,Orange\" (no spaces!) GoodLuck!\n—————————————————————————————————————————————————"
      discontinue = false
      until discontinue
        raw_inp = gets.chomp
        if proper_col_inp?(raw_inp)
          cleaned_inp = lower_case(raw_inp.split(','))
          if board.game_over?(cleaned_inp)
            discontinue = true
            puts "We have a winner!"
          end
          exac_pos = board.iden_col_and_pos(cleaned_inp)
          col_pos = board.contain_color?(cleaned_inp)
          
          if exac_pos == 1
            puts "#{exac_pos} piece is in the correct location."
          elsif exac_pos != 0
            puts "#{exac_pos} pieces are in the correct location."
          end
          
          only_col_match = col_pos - exac_pos

          if only_col_match == 1 && cleaned_inp.uniq.size != 1
            puts "#{only_col_match} piece is the correct color but not in the right location"
          elsif only_col_match != 0 && cleaned_inp.uniq.size != 1
            puts "#{only_col_match} pieces are the correct color but not in the right location"
          end
          
          #if already two of the same kind match so the
          #maximum number of matches then don't say the color is correct
          unless discontinue
            puts "Keep Guessing!\n—————————————————————————————————————————————————"
          end   
        else
          puts "You did not enter a valid guess!\n—————————————————————————————————————————————————"
        end
      end
    end
end

puts 'Hello! Welcome to Mastermind. Would you like to be the codebreaker
or the codemaker? Type "codebreaker" or "codemaker" below'
maker_breaker = gets.chomp
if correct_game_mode?(maker_breaker)
  main(maker_breaker)
end
