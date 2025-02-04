# require_relative '../config/resources'

class Piece

  attr_accessor :is_focused, :color, :square, :pin_image
  
  def initialize(square = nil)
    @square = square
    @color = get_color
    @is_focused = false
    @pin_image = Resources::IMAGES[:symbols][:pin]
  end

  def get_color
    if @square.row <= 1
      return :black
    elsif @square.row >= 6
      return :white
    else
      return nil
    end
  end

  def get_square(row, column)
    @square.board.squares[row][column]
  end

  def reset_focus
    @is_focused = false
    @square.board.focused_piece = nil
  end

  def change_focus(piece)
    @is_focused = false
    square.board.focused_piece = piece
    piece.is_focused = true
  end

  def turn_off_focus
    @is_focused = false
    @square.board.focused_piece = nil
  end

  def seen_square(vector)
    if (@square.row + vector[0]).between?(0,7) && (@square.col + vector[1]).between?(0,7)
      return get_square(@square.row + vector[0], @square.col + vector[1])
    else
      return nil
    end
  end

  def move(end_square)

    ChessTools.play_move_sound(end_square)

    @square.board.history << [[@square.row, @square.col], [end_square.row, end_square.col]]
    
    p @square.board.history
    @square.piece = nil
    @square = end_square
    end_square.piece = self 
  end

  def draw
    @image&.draw(@square.position[0], @square.position[1], 1, 0.83, 0.83)
    draw_seen_squares
    draw_pin
  end

  def draw_seen_squares
    if is_focused
      seen_squares&.each do |square|
        @square.board.highlight_img.draw(square.position[0], square.position[1], 1, 0.0488, 0.0488, Gosu::Color::WHITE, :additive)
      end
    end
  end

  def draw_pin
    @pin_image.draw(@square.position[0], @square.position[1], 2, 0.05, 0.05) if is_pinned?
  end

  def seen_squares
    raise NotImplementedError, "As classes filhas devem implementar este método"
  end


  def possible_moves
    if is_pinned?
      return []
    else
      return seen_squares
    end
    
    # seen_squares.select do |square|
    #   if square.piece
    #     false 
    #     next
    #   end
    #   move(square)
    #   is_checked = @square.board.kings[@color].in_check?
    #   move(@square)
    #   !is_checked
    # end
    # seen_squares
  end

  def is_pinned?
    initial_checking_pieces = @square.board.kings[@color].checking_pieces

    @square.piece = nil

    final_checking_pieces = @square.board.kings[@color].checking_pieces
  
    @square.piece = self

    return initial_checking_pieces != final_checking_pieces
  end

end
