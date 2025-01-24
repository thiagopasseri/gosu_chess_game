require_relative 'square'
require_relative 'chesstools'

class Board
  attr_accessor :squares, :highlight_img, :clicked_piece, :player_turn

  def initialize(pieces = nil)
    @squares = ChessTools.generate_squares(self)
    @highlight_img = Gosu::Image.new 'media/small_center_circle.png'
    @clicked_piece = nil
    @player_turn = 'white'
  end

  # def generate_squares
  #   group = []
  #   8.times do |row|
  #     row_arr = []
  #     8.times do |col|
  #       row_arr << Square.new(row, col, self)
  #     end
  #     group << row_arr 
  #   end
  #   group
  # end

  def draw_highlight_squares(squares)
    squares.each do |square|
      Gosu.draw_rect(
        square.position[0],
        square.position[1],
        SQUARE_SIZE,
        SQUARE_SIZE,
        Gosu::Color::WHITE,
        2,
        :default
      )
    end
  end

  def draw
    @squares.each do |row|
      row.each do |square|
        square.draw
      end
    end
    draw_highlight_squares(squares[@clicked_piece.square.row][@clicked_piece.square.col].column) if @clicked_piece
  end
end