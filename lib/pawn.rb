

class Pawn < Piece
  
  def initialize(square = nil)
    super
    @image = @color == 'white' ? Gosu::Image.new('media/Chess_plt60.png') : Gosu::Image.new('media/Chess_pdt60.png')
  end

  def draw
    @image.draw(@square.position[0], @square.position[1], 1, 0.83, 0.83)
  end

  def possible_moves
    moves = []
    step = @color == 'white' ? -1 : 1
    front_square = @square.board.squares[@square.row + step][@square.col] if (@square.row + step).between?(0,7)
    front_front_square = @square.board.squares[@square.row + 2 * step][@square.col] if (@square.row + 2 * step).between?(0,7)
    moves << front_square if front_square.piece == nil
    moves << front_front_square if front_front_square.piece == nil
  end
end