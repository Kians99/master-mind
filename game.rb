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

def turns_remaining(turns_left, sec_code)
  if turns_left == 0
    puts "Game Over—You ran out of turns!"
    puts "The correct code was #{sec_code}"
    true
  else
    false
  end
end



def guess_code(game_mode) 
    if game_mode.casecmp('codebreaker').zero?
      puts "—————————————————————————————————————————————————\nBeep Boop Bop.
The computer has thought of the four-length hidden color code. Yellow, White, Black, 
Brown, Orange, Red, Green, and Blue are all options for guessing. Please enter your
coordinates comma seperated like:\n\"Red,Green,Blue,Orange\" (no spaces!) GoodLuck!\n—————————————————————————————————————————————————"
      discontinue = false
      turns_left = 12
      board = Board.new(game_mode, [])
      until discontinue
        raw_inp = gets.chomp
        if proper_col_inp?(raw_inp)
          cleaned_inp = lower_case(raw_inp.split(','))
          if board.game_over?(cleaned_inp)
            discontinue = true
            puts "We have a winner! Four pieces are in the correct location!"
          end
          if !discontinue
            turns_left -= 1
            discontinue = turns_remaining(turns_left, board.code)
            board.all_checks_for_duplicates(cleaned_inp, discontinue)

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

def define_code(raw_inp, game_mode)
  if proper_col_inp?(raw_inp)
    cleaned_inp = lower_case(raw_inp.split(','))
    return Board.new(game_mode, cleaned_inp)
  else
    puts "Invalid code!"
  end
end

def computer_guess(colors)
  comp_guess = Array.new(0)
  4.times { comp_guess.push(colors.sample) }
  comp_guess
end


def user_makes_code(game_mode)
  colors = %w[yellow white black brown orange red green blue]
  if game_mode.casecmp('codemaker').zero?
    puts "—————————————————————————————————————————————————\nPlease enter a four-length hidden code you would like the computer to guess.
Enter your coordinates comma seperated like:\n\"Red,Green,Blue,Orange\" (no spaces!) GoodLuck!"
    discontinue = false
    turns_left = 12
    raw_inp = gets.chomp
    board = define_code(raw_inp, game_mode)

    if !board.nil?
      until discontinue
        
        comp_guess = computer_guess(colors)
        puts "—————————————————————————————————————————————————\nBeep Boop Boop I predict: "
        comp_guess.each_with_index do |color, index|
          if index != 3
            print "#{color},"
          else
            print "#{color}"
          end
        end

        puts "\nThe number of pieces that are the correct color AND in the right location:"
        exac_match = gets.chomp
        puts "\nThe number of pieces that are the correct color but NOT in the right location:"
        col_pos = gets.chomp



        if exac_match != 4 && exac_match.to_i != board.correct_color_and_location(comp_guess) || col_pos.to_i != board.only_correct_color(comp_guess, discontinue)
          puts "—————————————————————————————————————————————————\nLooks like you gave the computer the wrong directions. The correct values
will automatically be inserted."
        end
        
        exac_match = board.correct_color_and_location(comp_guess)
        col_pos = board.only_correct_color(comp_guess, discontinue)

        if exac_match != 4
          puts "The computer got it wrong! It will guess again."
        else
          puts "Muhaha. Looks like ai will rule the world. COMPUTER WINS!"
          discontinue = true
        end          

        if col_pos == 0 && exac_match == 0
          comp_guess.each do |color|
            colors.each do |m_col|
              if color == m_col
                colors.delete(color)
              end
            end
          end
        end

        if exac_match == 3 || col_pos == 3
          comp_guess.each do |color|
            colors.each do |m_col|
              if color == m_col
                2.times { colors.push(color) }
              end
            end
          end
        end

        if col_pos == 4
          comp_guess.each do |color|
            colors.each do |m_col|
              if color != m_col
                colors.delete(color)
              end
            end
          end
        end

        turns_left -= 1
        if turns_left == 0
          puts "Human wins! Computer ran out of guesses."
          discontinue = true
        end
      end

    end

  end
end

puts 'Hello! Welcome to Mastermind. Would you like to be the codebreaker
or the codemaker? Type "codebreaker" or "codemaker" below'
maker_breaker = gets.chomp
if correct_game_mode?(maker_breaker)
  if maker_breaker == "codebreaker"
    guess_code(maker_breaker)
  else
    user_makes_code(maker_breaker)
  end
end
