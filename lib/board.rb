require_relative 'square'
require_relative 'chesstools'

class Board
  attr_accessor :squares, :highlight_img, :focused_piece, :current_player, :players, :menu, :history, :current_history

  def initialize
    @squares = ChessTools.generate_squares(self)

    @players = {
      white: Player.new(self, :white),
      black: Player.new(self, :black)
    }
    @current_player = @players[:white]

    @focused_piece = nil

    @menu = Menu.new(self)
    @highlight_img = Gosu::Image.new 'media/small_center_circle.png'
    @history = []
    @current_history = @history
  end

  def kings
    {
      white: get_piece_by_name(:king)[:white],
      black: get_piece_by_name(:king)[:black]
    }
  end

  def refresh
    initialize
  end

  def play_all_history(history)
    refresh
    history.each do |initial_coord, final_coord|
      p initial_coord
      p final_coord
      initial_square = @squares[initial_coord[0]][initial_coord[1]]
      final_square = @squares[final_coord[0]][final_coord[1]]
      
      initial_square.piece.move(final_square)
    end
  end

  def play_next_move
    if @current_history.size != 0
      puts "teeeeste"
      puts @current_history.size
      current_move_coord = @current_history.shift

      initial_coord = current_move_coord[0]
      final_coord = current_move_coord[1]
  
      initial_square = @squares[initial_coord[0]][initial_coord[1]]
      final_square = @squares[final_coord[0]][final_coord[1]]
  
      initial_square.piece.move(final_square)
    end
  end


  
  def clear
    @squares.flatten.each do |square|
      square.piece = nil
    end
  end

  def draw
    @squares.each do |row|
      row.each do |square|
        square.draw
      end
    end

    ChessTools.draw_highlight_squares(@current_player.all_seen_squares, Resources::COLORS[:weak_red]) 
    ChessTools.draw_img_squares(@current_player.all_possible_moves, Resources::IMAGES[:symbols][:green_check])

    # ChessTools.draw_highlight_squares(squares[@focused_piece.square.row][@focused_piece.square.col].line_squares([1,1])) if @focused_piece
  end

  def change_player
    @current_player = @current_player == @players[:white] ? @players[:black] : @players[:white]
  end

  def get_piece_by_name(name)
    occupied_squares = squares.flatten.select { |square|  square.piece&.name == name}
    pieces = occupied_squares.map { |square| square.piece }
    pieces_hash = pieces.each_with_object({}) {|piece, hash| hash[piece.color.to_sym] = piece}
    pieces_hash
  end
end