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
          code_num = board.num_colors_in_code
          col_pos = board.contain_color?(cleaned_inp)

          avoid_col = Hash.new(0)
          exac_pos.each do |color, num|
            code_num.each do |col, nu|
              if color == col && nu >= num
                avoid_col[col] = num
              end
            end
          end

          p "WE COME IN PEACE"
          p avoid_col

          total = 0
          exac_pos.each do |_, num|
            total += num
          end

          if total == 1
            puts "#{total} piece is in the correct location."
          elsif exac_pos != 0
            puts "#{total} pieces are in the correct location."
          end


          avoid_col.each do |color, number|
            col_pos.each do |col, num|
              if color == col
                col_pos.delete(color)
              end
            end
          end


          includes_total = 0
          col_pos.each do |_, num|
            includes_total += num
          end
          
          
          if includes_total == 1
            puts "#{includes_total} piece is the correct color but not in the right location"
          elsif includes_total != 0
            puts "#{includes_total} pieces are the correct color but not in the right location"
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
