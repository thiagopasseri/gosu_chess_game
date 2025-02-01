require_relative 'square'
require_relative 'chesstools'

class Board
  attr_accessor :squares, :highlight_img, :clicked_piece, :player_turn

  def initialize(pieces = nil)
    @squares = ChessTools.generate_squares(self)
    @highlight_img = Gosu::Image.new 'media/small_center_circle.png'
    @clicked_piece = nil
    @player_turn = :white
  end

  

  def draw
    @squares.each do |row|
      row.each do |square|
        square.draw
      end
    end

    ChessTools.draw_highlight_squares(all_seen_squares(@player_turn)) 

    # ChessTools.draw_highlight_squares(squares[@clicked_piece.square.row][@clicked_piece.square.col].line_squares([1,1])) if @clicked_piece
  end

  def all_seen_squares(color)
    all = []
    @squares.flatten.each do |square| 
      if square.piece
        all += square.piece.seen_squares if square.piece.color == color
      end
    end
    all
  end

end