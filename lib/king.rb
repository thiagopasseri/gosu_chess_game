class King < Piece

  attr_accessor :name

  
  def initialize(square = nil)
    super
    @image = Resources::IMAGES[:pieces][@color][:king]
    @directions = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, 1], [-1, 1], [1, -1], [-1, -1]]
    @name = :king
    @check_image = Resources::IMAGES[:symbols][:red_check]


  end

  def draw
    super
    @check_image.draw(@square.position[0], @square.position[1], 1, 0.04, 0.04) if in_check?
  end


  def seen_squares
    group = []
    @directions.each do |direction|
      target_row = @square.row + direction[0]
      target_column = @square.col + direction[1]
      if ChessTools.in_board?(target_row, target_column) && ChessTools.get_piece(target_row, target_column, @square.board)&.color != @square&.piece.color
        group << @square.get_square(target_row, target_column) 
      end
    end
    group
  end

  def in_check?
    opposite_color = ChessTools.opposite_color(@color)
    opposite_player = @square.board.players[opposite_color]
    opposite_player.all_seen_squares.include?(@square)
  end

  def checking_pieces
    opposite_color = ChessTools.opposite_color(@color)
    pieces = []
    @square.board.players[opposite_color].player_pieces.each do |piece|
      next if piece.name == :king
      pieces << piece if piece.seen_squares.include?(@square) 
    end
    pieces
  end
  
  # consertar checking pieces
  def checking_pieces_names
    opposite_color = ChessTools.opposite_color(@color)
    pieces_names = []
    @square.board.players[opposite_color].player_pieces.each do |piece|
      pieces_names << piece.name if piece.seen_squares.include?(@square)
    end
    pieces_names
  end

  def is_pinned?
    false
  end
end