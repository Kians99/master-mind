#computer class
class Board
  COLORS = %w[Yellow White Black Brown Orange Red Green Blue].freeze

  def initialize
    @code = Array.new(0)
    4.times { @code.push(COLORS.sample) }
    
  end 

  def is_game_over?
    false

  end
end
