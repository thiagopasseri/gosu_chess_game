class Queen < Piece
  
  def initialize(square = nil)
    super
    @image = @color == 'white' ? Gosu::Image.new('media/Chess_qlt60.png') : Gosu::Image.new('media/Chess_qdt60.png')
  end

  def draw
    @image.draw(@square.position[0], @square.position[1], 1, 0.83, 0.83)
  end
end