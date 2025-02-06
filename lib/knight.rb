class Knight < Piece
  
  attr_accessor :name

  def initialize(square = nil)
    super
    @image = Resources::IMAGES[:pieces][@color][:knight]
    @name = :knight

    # @mov_vectors = [[2, 1], [2, -1], [1, 2], [-1, 2] ,[1, -2] ,[-1, -2], [-2, 1], [-2, -1]]
  end


  def calculate_seen_squares
    moves = []
    ChessTools.get_knight_moves_coord(@square.row, @square.col).each do |row, column|
      target_square = get_square(row, column)
      moves << target_square if target_square.piece&.color != @color
    end
    moves
  end
end