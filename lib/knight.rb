class Knight < Piece
  
  def initialize(square = nil)
    super
    @image = @color == 'white' ? Gosu::Image.new('media/Chess_nlt60.png') : Gosu::Image.new('media/Chess_ndt60.png')
    @mov_vectors = [[2, 1], [2, -1], [1, 2], [-1, 2] ,[1, -2] ,[-1, -2], [-2, 1], [-2, -1]]
  end

  def possible_moves
    moves = []
    @mov_vectors.each do |vector|
      if seen_square(vector)
        target_square = get_square(@square.row + vector[0],@square.col + vector[1]) 
      end
      moves << target_square if target_square != nil
    end
    moves
  end

  #terminei escrevendo possible_moves




end