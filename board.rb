#computer class
class Board
  COLORS = %w[yellow white black brown orange red green blue].freeze

  def initialize
    
    @code = Array.new(0)
    4.times { @code.push(COLORS.sample) }
    num_colors_in_code

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
end