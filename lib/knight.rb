class Knight < Piece
  
  def initialize(square = nil)
    super
    @image = @color == 'white' ? Gosu::Image.new('media/Chess_nlt60.png') : Gosu::Image.new('media/Chess_ndt60.png')
    @movement_vectors = [[2, 1], [2, -1], [1, 2], [-1, 2] ,[1, -2] ,[-1, -2], [-2, 1], [-2, -1]]
  end

  def draw
    @image.draw(@square.position[0], @square.position[1], 1, 0.83, 0.83)
  end

  def possible_moves
    moves = []
    @movement_vectors.each do |vector|
      if seen_square(vector)
        target_square = get_square(@square.row + vector[0],@square.col + vector[1]) 
      end
      moves << target_square if target_square != nil
    end
    moves
  end

  #terminei escrevendo possible_moves




end