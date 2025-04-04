require_relative 'piece'
require 'gosu'
require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'king'
require_relative 'queen'
require_relative 'bishop'




# COR_CLIKED = Gosu::Color.rgba(255, 0, 0, 128)
# COR_COTTON = Gosu::Color.rgba(250, 244, 211, 200)
# COR_BUDDHA = Gosu::Color.rgba(189, 155, 25, 255)
# COR_LIGHTWOOD = Gosu::Color.rgba(130, 94, 92, 255)
# COR_GREEN = Gosu::Color.rgba(183, 244, 216, 255)
SQUARE_SIZE = 50



class Square

  attr_accessor :row, :col, :piece, :position, :board, :square_size
  
  def initialize(row, col, board)
    @row = row
    @col = col
    @board = board
    @color = get_color
    @position = [Resources::BOARD[:padding] + @col * SQUARE_SIZE, Resources::BOARD[:padding] + @row * SQUARE_SIZE]
    @piece = nil
    @square_size = Resources::BOARD[:square_size]
  end

  def setup_piece(piece_type)
    @piece = case piece_type
    when :king
      King.new(self)
    when :queen
      Queen.new(self)
    when :rook
      Rook.new(self)
    when :bishop
      Bishop.new(self)
    when :knight
      Knight.new(self)
    when :pawn
      Pawn.new(self)
    else
      nil
    end
  end


  def setup_default_piece
    return nil if @row.between?(2,5) 
    @piece = if @row == 1 || @row == 6
      Pawn.new(self)
    elsif @row == 0 || @row == 7
      case @col
      when 0, 7
        Rook.new(self)
      when 1, 6
        Knight.new(self)
      when 2, 5
        Bishop.new(self)
      when 3
        Queen.new(self)
      when 4
        King.new(self)
      end
    end
  end

  def get_piece
    if @board.initial_condition.nil?
      puts "board initial condition: #{@board.initial_condition} #{@board.initial_condition.class}"
      return nil if @row.between?(2,5) 
      if @row == 1 || @row == 6
        return Pawn.new(self)
      elsif @row == 0 || @row == 7
        case @col
        when 0, 7
          return Rook.new(self)
        when 1, 6
          return Knight.new(self)
        when 2, 5
          return Bishop.new(self)
        when 3
          return Queen.new(self)
        when 4
          return King.new(self)
        end
        return nil
      end
    end
  end
  
  def get_color
    color = (@col + @row)%2 == 0 ? Resources::COLORS[:cotton] : Resources::COLORS[:lightwood]
  end

  def rect
    [Resources::BOARD[:padding] + @col * @square_size, Resources::BOARD[:padding] + @row * @square_size, @square_size, @square_size]
  end

  def draw
    draw_square
    draw_highlight(Resources::COLORS[:green]) if @piece&.is_focused
    @piece&.draw
    # @piece&.pin_image&.draw(150, 150, 2, 0.1, 0.1)

  end

  def get_square(row, column)
    @board.squares[row][column]
  end

  def draw_rect_outline(x, y, width, height, color, z=0, mode=:default, thickness=2)
    thickness.times do |i|
      Gosu.draw_line(x, y + i, color, x + width, y + i, color, z, mode)
      Gosu.draw_line(x, y + height - i, color, x + width, y + height - i, color, z, mode)
      Gosu.draw_line(x + i, y, color, x + i, y + height, color, z, mode)
      Gosu.draw_line(x + width - i, y, color, x + width - i, y + height, color, z, mode)
    end
  end

  def row_squares
    @board.squares[@row]
  end

  def column_squares
    group = []
    @board.squares.each do |row|
      group << row[@col]
    end
    group
  end

  def line_squares(direction)
    group = []
    ChessTools.get_line_coord([@row, @col], direction).each do |row, column|
      group << @board.squares[row][column]
    end
    group
  end

  def seen_line_squares(direction)
    group = []
    ChessTools.get_seen_line_coord(@row, @col, direction, @board).each do |row, column|
      group << @board.squares[row][column]
    end
    group
  end

  def draw_square
    Gosu.draw_rect(
      position[0],
      position[1],
      @square_size,
      @square_size,
      @color 
    )
  end

  def draw_highlight(color)
    draw_rect_outline(
      position[0],
      position[1],
      @square_size,
      @square_size,
      color,
      1,
      :default,
      5
    ) 
  end
end