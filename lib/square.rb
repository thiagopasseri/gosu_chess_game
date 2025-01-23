require_relative 'piece'
require 'gosu'
require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'king'
require_relative 'queen'
require_relative 'bishop'




COR_CLIKED = Gosu::Color.rgba(255, 0, 0, 128)
COR_COTTON = Gosu::Color.rgba(250, 244, 211, 200)
COR_BUDDHA = Gosu::Color.rgba(189, 155, 25, 255)
COR_LIGHTWOOD = Gosu::Color.rgba(130, 94, 92, 255)
COR_GREEN = Gosu::Color.rgba(183, 244, 216, 255)
SQUARE_SIZE = 50



class Square

  attr_accessor :row, :col, :piece, :position, :board
  
  def initialize(row, col, board)
    @row = row
    @col = col
    @board = board
    @color = get_color
    @position = [PADDING + @col * SQUARE_SIZE, PADDING + @row * SQUARE_SIZE]
    @piece = get_piece
  end

  def get_piece
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
  
  def get_color
    color = (@col + @row)%2 == 0 ? COR_COTTON : COR_LIGHTWOOD
  end

  def rect
    [PADDING + @col * SQUARE_SIZE, PADDING + @row * SQUARE_SIZE, SQUARE_SIZE, SQUARE_SIZE]
  end

  def draw
    draw_square
    draw_highlight(COR_GREEN) if @piece&.is_clicked
    @piece&.draw
    @piece&.draw_possible_moves
  end


  def draw_rect_outline(x, y, width, height, color, z=0, mode=:default, thickness=2)
    thickness.times do |i|
      Gosu.draw_line(x, y + i, color, x + width, y + i, color, z, mode)
      Gosu.draw_line(x, y + height - i, color, x + width, y + height - i, color, z, mode)
      Gosu.draw_line(x + i, y, color, x + i, y + height, color, z, mode)
      Gosu.draw_line(x + width - i, y, color, x + width - i, y + height, color, z, mode)
    end
  end

  def draw_square
    Gosu.draw_rect(
      position[0],
      position[1],
      SQUARE_SIZE,
      SQUARE_SIZE,
      @color 
    )
  end

  def draw_highlight(color)
    draw_rect_outline(
      position[0],
      position[1],
      SQUARE_SIZE,
      SQUARE_SIZE,
      COR_GREEN,
      1,
      :default,
      5
    ) 
  end
    

end