class Rook < Piece
  
  def initialize(square = nil)
    super
    @image = Resources::IMAGES[:pieces][@color][:rook]
    @directions = [[1, 0], [0, 1], [-1, 0], [0, -1]]

  end

  def draw
    @image.draw(@square.position[0], @square.position[1], 1, 0.83, 0.83)
  end

  def possible_moves
    group = []
    @directions.each do |direction|
      group += @square.seen_line_squares(direction)
    end
    group
  end
  
end