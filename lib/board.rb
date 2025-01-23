require_relative 'square'

class Board
  attr_accessor :squares, :highlight_img, :clicked_piece, :player_turn

  def initialize(pieces = nil)
    @squares = generate_squares
    @highlight_img = Gosu::Image.new 'media/small_center_circle.png'
    @clicked_piece = nil
    @player_turn = 'white'
  end

  def generate_squares
    group = []
    8.times do |row|
      row_arr = []
      8.times do |col|
        row_arr << Square.new(row, col, self)
      end
      group << row_arr 
    end
    group
  end

  def draw
    @squares.each do |row|
      row.each do |square|
        square.draw
      end
    end
  end
end