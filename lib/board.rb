require_relative 'square'
require_relative 'chesstools'

class Board
  attr_accessor :squares, :highlight_img, :clicked_piece, :player_turn, :kings

  def initialize(pieces = nil)
    @squares = ChessTools.generate_squares(self)
    @highlight_img = Gosu::Image.new 'media/small_center_circle.png'
    @clicked_piece = nil
    @player_turn = :white
    @kings = {
      white: get_piece_by_name(:king)[:white],
      black: get_piece_by_name(:king)[:black]
    }
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

  def get_piece_by_name(name)
    occupied_squares = squares.flatten.select { |square|  square.piece&.name == name}
    pieces = occupied_squares.map { |square| square.piece }
    pieces_hash = pieces.each_with_object({}) {|piece, hash| hash[piece.color.to_sym] = piece}
    pieces_hash
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