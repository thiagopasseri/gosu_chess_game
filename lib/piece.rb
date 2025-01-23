class Piece

  attr_accessor :is_clicked, :color
  
  def initialize(square = nil)
    @square = square
    @color = get_color
    @is_clicked = false
    @image = nil
  end

  def get_color
    if @square.row <= 1
      return 'black'
    elsif @square.row >= 6
      return 'white'
    else
      return nil
    end
  end

  def get_square(row, column)
    @square.board.squares[row][column]
  end


  def seen_square(vector)
    if (@square.row + vector[0]).between?(0,7) && (@square.col + vector[1]).between?(0,7)
      return get_square(@square.row + vector[0], @square.col + vector[1])
    else
      return nil
    end
  end

  def seen_squares(group)
    squares = []
    group.each do |vector|
      squares << seen_square(vector)
    end
    squares
  end

  def move(end_square)
    puts "end_square - [#{end_square.row}][#{end_square.col}] - #{end_square.piece.class}"
    return nil if end_square.piece != nil

    @square.piece = nil
    @square = end_square
    end_square.piece = self
  end


  def draw
    @image&.draw(@square.position[0], @square.position[1], 1, 0.83, 0.83)
  end

  def draw_possible_moves
    if is_clicked
      possible_moves&.each do |square|
        @square.board.highlight_img.draw(square.position[0], square.position[1], 2, 0.0488, 0.0488, Gosu::Color::WHITE, :additive)
      end
    end
  end


  def possible_moves
    raise NotImplementedError, "As classes filhas devem implementar este método"
  end

end
