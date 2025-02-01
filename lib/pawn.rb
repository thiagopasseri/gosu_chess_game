

class Pawn < Piece

  attr_accessor :name

  
  def initialize(square = nil)
    super
    @image = Resources::IMAGES[:pieces][@color][:pawn]
    @name = :pawn

  end

  def seen_squares
    free_square_moves + taking_moves
  end

  def free_square_moves
    moves = []

    orientation = @color == :white  ? -1 : 1
    
    target_square = get_square(@square.row + orientation ,@square.col)

    if @square.row == 6 && @color == :white  || @square.row == 1 && @color == :black
      extra_target_square = get_square(@square.row + 2 * orientation,@square.col)
    end

    if target_square 
      moves << target_square unless target_square.piece
    end
    if extra_target_square
      moves << extra_target_square unless extra_target_square.piece
    end
    moves
  end

  def taking_moves
    moves = []
    orientation = @color == :white ? -1 : 1
    target_square_left = get_square(@square.row + orientation,@square.col + orientation)
    target_square_right = get_square(@square.row + orientation,@square.col - orientation)

    moves << target_square_left if target_square_left&.piece&.color == ChessTools.opposite_color(@color)
    moves << target_square_right if target_square_right&.piece&.color == ChessTools.opposite_color(@color)
    moves

  end
end