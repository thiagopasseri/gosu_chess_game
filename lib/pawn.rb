

class Pawn < Piece
  
  def initialize(square = nil)
    super
    @image = Resources::IMAGES[:pieces][@color][:pawn]
    @mov_vectors = [[1,0]]
  end

  def possible_moves
    free_square_moves
 
  end

  def free_square_moves
    moves = []

    orientation = @color == :white  ? -1 : 1
    mov_vector = @mov_vectors[0].map {|element| orientation * element}
    
    target_square = get_square(@square.row + mov_vector[0],@square.col + mov_vector[1])
    puts "target_square: [#{target_square.row}][#{target_square.col}]"

    if @square.row == 6 && @color == :white  || @square.row == 1 && @color == :black
      extra_target_square = get_square(@square.row + 2 * mov_vector[0],@square.col + 2 *mov_vector[1])
    end

    moves << target_square if target_square != nil
    moves << extra_target_square if extra_target_square
    moves
  end

  def taking_moves
    moves = []
    orientation = @color == :white ? -1 : 1
    target_square_left = get_square(@square.row + mov_vector[0],@square.col - mov_vector[1])


  end

end