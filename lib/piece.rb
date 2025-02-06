# require_relative '../config/resources'

class Piece

  attr_accessor :is_focused, :color, :square, :pin_image
  
  def initialize(square = nil)
    @square = square
    @color = get_color
    @is_focused = false
    @pin_image = Resources::IMAGES[:symbols][:pin]

    @cached_possible_moves = nil
    @cached_seen_squares = nil
    @last_board_state = nil
  end

  def get_color
    if @square.row <= 2
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

  def move(end_square, sound_on = true)
    ChessTools.play_move_sound(end_square) if sound_on

    @square.board.history << [[@square.row, @square.col], [end_square.row, end_square.col]]

    invalidate_cache

    @square.piece = nil
    @square = end_square
    end_square.piece = self 
  end


  def fake_move(end_square, sound_on = false)
    ChessTools.play_move_sound(end_square) if sound_on

    # @square.board.history << [[@square.row, @square.col], [end_square.row, end_square.col]]

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
    return unless is_focused
    calculate_seen_squares&.each do |square|
      @square.board.highlight_img.draw(square.position[0], square.position[1], 1, 0.0488, 0.0488, Gosu::Color::WHITE, :additive)
    end
  end

  def draw_pin
    @pin_image.draw(@square.position[0], @square.position[1], 2, 0.05, 0.05) if is_pinned?
  end

  def calculate_seen_squares
    raise NotImplementedError, "As classes filhas devem implementar este método"
  end

  def seen_squares
    current_board_state = board_state_hash
    if @cached_seen_squares.nil? || @last_board_state != current_board_state
      @last_board_state = current_board_state
      @cached_seen_squares = calculate_seen_squares
    end
    @cached_seeen_squares
  end

  def possible_moves
    current_board_state = board_state_hash
    if @cached_possible_moves.nil? || @last_board_state != current_board_state 
      @last_board_state = current_board_state
      @cached_possible_moves = calculate_possible_moves
    end
    @cached_possible_moves
  end

  
  def calculate_possible_moves
    calculate_seen_squares.select do |square|
      # initial_checks = @square.board.players[@color].king.checking_pieces

      target_piece = square.piece  #piece is pointing to target_square
      initial_square = @square

      fake_move(square)
      final_checks = @square.board.players[@color].king.checking_pieces
      condition = final_checks.empty?

      #desfaz o move
      @square = initial_square
      initial_square.piece = self
      square.piece = target_piece 

      condition
    end
  end

  def invalidate_cache
    @cached_possible_moves = nil
    @cached_seen_squares = nil
    @last_board_state = nil
  end

  def is_pinned?
    initial_checking_pieces = @square.board.kings[@color].checking_pieces
    @square.piece = nil

    final_checking_pieces = @square.board.kings[@color].checking_pieces
    @square.piece = self

    return initial_checking_pieces != final_checking_pieces
  end
  
  def board_state_hash
    puts "calculou o HASH"
    # Cria uma string única representando o estado atual do tabuleiro
    board_state = ""
    @square.board.squares.each do |row|
      row.each do |square|
        piece = square.piece
        board_state << if piece
          "#{piece.class.name[0]}#{piece.color[0]}#{square.row}#{square.col}"
        else
          "---"
        end
      end
    end
    board_state
  end
end
