class Player
  
  attr_accessor :color

  def initialize(board, color)
    @color = color
    @board = board
    @king = board.get_piece_by_name(:king)[color]
  end


  def all_seen_squares
    all = []
    @board.squares.flatten.each do |square| 
      if square.piece
        all += square.piece.seen_squares if square.piece.color == @color
      end
    end
    all
  end

end