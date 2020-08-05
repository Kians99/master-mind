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

def avoid_color(exac_pos, code_num)
  avoid_col = Hash.new(0)
    exac_pos.each do |color, num|
      code_num.each do |col, nu|
        if color == col && nu == num
          avoid_col[col] = num
        end
      end
    end
    avoid_col
end


def hash_sum(hash)
  total = 0
  hash.each do |_, num|
    total += num
  end
  total
end

def guess_code(game_mode)
    board = Board.new 
    if game_mode.casecmp('codebreaker').zero?
      puts "—————————————————————————————————————————————————\nBeep Boop Bop.
The computer has thought of the four-length hidden color code. Yellow, White, Black, 
Brown, Orange, Red, Green, and Blue are all options for guessing. Please enter your
coordinates comma seperated like:\n\"Red,Green,Blue,Orange\" (no spaces!) GoodLuck!\n—————————————————————————————————————————————————"
      discontinue = false
      turns_left = 12
      until discontinue
        raw_inp = gets.chomp
        if proper_col_inp?(raw_inp)
          cleaned_inp = lower_case(raw_inp.split(','))
          if board.game_over?(cleaned_inp)
            discontinue = true
            puts "We have a winner! Four pieces are in the correct location!"
          end

          exac_pos = board.iden_col_and_pos(cleaned_inp)
          code_num = board.num_colors_in_code
          col_pos = board.contain_color?(cleaned_inp)
          avoid_col = avoid_color(exac_pos, code_num)
          total_of_exact = hash_sum(exac_pos)

          if total_of_exact == 1
            puts "#{total_of_exact} piece is in the correct location!"
          elsif total_of_exact != 0 && !discontinue
            puts "#{total_of_exact} pieces are in the correct location!"
          end

          avoid_col.each do |color, number|
            col_pos.each do |col, num|
              if color == col
                col_pos.delete(color)
              end
            end
          end

          exac_pos.each do |color, number|
            col_pos.each do |col, num|
              if color == col 
                col_pos[color] = num - number
              end
            end
           end

          code_num.each do |color, number| 
            col_pos.each do |col, num|
              if color == col && num > number
                col_pos[color] = number
              end
            end
          end

          total_corr_color = hash_sum(col_pos)
          
          if total_corr_color == 1
            puts "#{total_corr_color} piece is the correct color but not in the right location"
          elsif total_corr_color != 0
            puts "#{total_corr_color} pieces are the correct color but not in the right location"
          end
          
          turns_left -= 1
          if turns_left == 0
            discontinue = true
            puts "Game Over—You ran out of turns!"
          end

          unless discontinue
            puts "Keep Guessing!\n—————————————————————————————————————————————————"
          end
        else
          puts "You did not enter a valid guess!\n—————————————————————————————————————————————————"
        end
      end
    end
end

def make_code
end

puts 'Hello! Welcome to Mastermind. Would you like to be the codebreaker
or the codemaker? Type "codebreaker" or "codemaker" below'
maker_breaker = gets.chomp
if correct_game_mode?(maker_breaker)
  if maker_breaker == "codebreaker"
    guess_code(maker_breaker)
  else
    make_code(maker_breaker)
  end
end
