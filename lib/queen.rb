# require_relative '../config/resources'


class Queen < Piece
  
  def initialize(square = nil)
    super
    @image = Resources::IMAGES[:pieces][@color][:queen]
  end

  def draw
    @image.draw(@square.position[0], @square.position[1], 1, 0.83, 0.83)
  end
end