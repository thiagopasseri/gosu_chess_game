class Bishop < Piece
  
  attr_accessor :name

  def initialize(square = nil)

    super
    @image = Resources::IMAGES[:pieces][@color][:bishop]
    @directions = [[1, 1], [-1, 1], [1, -1], [-1, -1]]
    @name = :bishop
  end

  def draw
    @image.draw(@square.position[0], @square.position[1], 1, 0.83, 0.83)
  end

  def calculate_seen_squares
    group = []

    @directions.each do |direction|
      group += @square.seen_line_squares(direction)
    end
    group
  end
end