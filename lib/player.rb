class Player
  
  attr_accessor :color

  def initialize(board, color)
    @color = color
    @board = board
    @king = board.get_piece_by_name(:king)[color]
  end

end