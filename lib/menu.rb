class Menu
  
  def initialize(board)
    @board = board
    @players = board.players
    @background_color = Resources::COLORS[:menu_background]
    @font = Gosu::Font.new(15)  # Fonte para renderizar o texto
    @font_color = Gosu::Color::WHITE
  end


  def draw
    Gosu.draw_rect(
      get_board_x_coord,
      get_board_y_coord,
      350,
      300,
      @background_color
    )

    @font.draw_text(
      get_text,
      get_board_x_coord,
      get_board_y_coord + 50,
      1,
      1.0,
      1.0,
      @font_color)
  end

  def get_board_x_coord
    @board.squares[0][7].position[0] + @board.squares[0][0].square_size * 1.5
  end

  def get_board_y_coord
    @board.squares[1][7].position[1]
  end

  def get_text
    <<~TEXT
    Focused Piece: #{@board.focused_piece}
    - possible_moves: #{@board.focused_piece&.possible_moves.inspect}
    White checks: #{@board.players[:white].king.checking_pieces_names.inspect}
    Black checks: #{@board.players[:black].king.checking_pieces_names.inspect}
    Pinned white Pieces: #{@board.players[:white].pinned_pieces_names.inspect}
    Pinned black Pieces: #{@board.players[:black].pinned_pieces_names.inspect}

    TEXT
  end
end