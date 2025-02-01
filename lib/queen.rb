# require_relative '../config/resources'


class Queen < Piece
  
  def initialize(square = nil)
    super
    @image = Resources::IMAGES[:pieces][@color][:queen]
    @directions = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, 1], [-1, 1], [1, -1], [-1, -1]]

  end

  def draw
    @image.draw(@square.position[0], @square.position[1], 1, 0.83, 0.83)
  end

  def seen_squares
    group = []
    @directions.each do |direction|
      group += @square.seen_line_squares(direction)
    end
    group
  end
end