class Board
  COLORS = %w[yellow white black brown orange red green blue].freeze

  def initialize(game_mode, make_code)
    if game_mode == "codebreaker"
      @code = Array.new(0)
      4.times { @code.push(COLORS.sample) }
      num_colors_in_code
    else 
      @code = make_code
    end

  
  end 

  attr_reader :code
  
  def contain_color?(input_cols)
    num_col = Hash.new(0)
    input_cols.each do |col|
      if code.include?(col)
        num_col[col] += 1
      end
    end
    num_col
  end

  def num_colors_in_code
    num_col = Hash.new(0)
    code.each do |val|
      num_col[val] += 1
    end
    num_col
  end

  def iden_col_and_pos(input_cols)
    perf_matches = Hash.new(0)
    for i in 0..input_cols.length - 1 
      if code[i] == input_cols[i]
        perf_matches[code[i]] += 1 
      end
    end
    perf_matches
  end

  def game_over?(input_cols)
    input_cols == code
  end



  def remove_color(avoid_col, col_pos)
    avoid_col.each do |color, number|
      col_pos.each do |col, num|
        if color == col
          col_pos.delete(color)
        end
      end
    end
  end

def same_color(exac_pos, col_pos)
  exac_pos.each do |color, number|
    col_pos.each do |col, num|
      if color == col 
        col_pos[color] = num - number
      end
    end
   end
end


def color_dif(code_num, col_pos)
  code_num.each do |color, number| 
    col_pos.each do |col, num|
      if color == col && num > number
        col_pos[color] = number
      end
    end
  end
end

def hash_sum(hash)
  total = 0
  hash.each do |_, num|
    total += num
  end
  total
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

def exact_matches(total_of_exact, discontinue)
  if total_of_exact == 1
    puts "#{total_of_exact} piece is in the correct location!"
  elsif total_of_exact != 0 && !discontinue
    puts "#{total_of_exact} pieces are in the correct location!"
  end
end


def not_exact_matches(total_corr_color)
  if total_corr_color == 1
    puts "#{total_corr_color} piece is the correct color but not in the right location"
  elsif total_corr_color != 0
    puts "#{total_corr_color} pieces are the correct color but not in the right location"
  end
end

def correct_color_and_location(cleaned_inp)
  exac_pos = iden_col_and_pos(cleaned_inp)
  total_of_exact = hash_sum(exac_pos)
  return total_of_exact
end

def only_correct_color(cleaned_inp, discontinue)
  exac_pos = iden_col_and_pos(cleaned_inp)
  code_num = self.num_colors_in_code
  col_pos = contain_color?(cleaned_inp)
  avoid_col = avoid_color(exac_pos, code_num)
  total_of_exact = hash_sum(exac_pos)
  #exact_matches(total_of_exact, discontinue)
  remove_color(avoid_col, col_pos)
  same_color(exac_pos, col_pos)
  color_dif(code_num, col_pos)
  total_corr_color = hash_sum(col_pos)
  total_corr_color
end

def all_checks_for_duplicates(cleaned_inp, discontinue)

  exac_pos = iden_col_and_pos(cleaned_inp)
  code_num = self.num_colors_in_code
  col_pos = contain_color?(cleaned_inp)
  avoid_col = avoid_color(exac_pos, code_num)
  total_of_exact = hash_sum(exac_pos)
  if !discontinue
    exact_matches(total_of_exact, discontinue)
    remove_color(avoid_col, col_pos)
    same_color(exac_pos, col_pos)
    color_dif(code_num, col_pos)
    total_corr_color = hash_sum(col_pos)
    not_exact_matches(total_corr_color)
  end
end

end