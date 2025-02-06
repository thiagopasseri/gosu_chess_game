class Rook < Piece
  
  attr_accessor :name


  def initialize(square = nil)


    super
    @image = Resources::IMAGES[:pieces][@color][:rook]
    @directions = [[1, 0], [0, 1], [-1, 0], [0, -1]]
    @name = :rook


  end

  def calculate_seen_squares
    group = []
    @directions.each do |direction|
      group += @square.seen_line_squares(direction)
    end
    group
  end
  
end