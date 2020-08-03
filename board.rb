#computer class
class Board
  COLORS = %w[yellow white black brown orange red green blue].freeze

  def initialize
    @code = Array.new(0)
    4.times { @code.push(COLORS.sample) }
  end 

  attr_reader :code
  
  def contain_color?(input_cols)
    count = 0
    input_cols.each do |col|
      if code.include?(col)
        count += 1
      end
    end
    count
  end

  def iden_col_and_pos(input_cols)
    count = 0
    for i in 0..input_cols.length - 1
      if code[i] == input_cols[i]
        count += 1
      end
    end
    count
  end

  def game_over?(input_cols)
    input_cols == code
  end
end