require_relative 'square'
require_relative 'chesstools'

class Board
  attr_accessor :squares, :highlight_img, :focused_piece, :current_player, :kings

  def initialize(pieces = nil)
    @squares = ChessTools.generate_squares(self)

    @white_player = Player.new(self, :white)
    @black_player = Player.new(self, :black)

    @focused_piece = nil
    @current_player = @white_player
    @kings = {
      white: get_piece_by_name(:king)[:white],
      black: get_piece_by_name(:king)[:black]
    }
    @highlight_img = Gosu::Image.new 'media/small_center_circle.png'

  end


  def draw
    @squares.each do |row|
      row.each do |square|
        square.draw
      end
    end

    ChessTools.draw_highlight_squares(all_seen_squares(@current_player)) 

    # ChessTools.draw_highlight_squares(squares[@focused_piece.square.row][@focused_piece.square.col].line_squares([1,1])) if @focused_piece
  end

  def change_player
    current_player = current_player == @white_player ? @black_player : @white_player
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