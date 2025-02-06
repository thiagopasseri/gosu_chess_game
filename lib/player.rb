class Player
  
  attr_accessor :color, :pieces

  def initialize(board, color)
    @color = color
    @board = board
  end


  def king
    @king ||= @board.kings[@color]
  end

  def all_seen_squares
    all = []
    player_pieces.each do |piece|
      all += piece.calculate_seen_squares
    end
    all
  end

  def all_possible_moves
    all = []
    player_pieces.each do |piece|
      all += piece.possible_moves
    end
    all
  end

  def player_pieces
    square_pieces = @board.squares.flatten.select { |square| square.piece && square.piece.color == @color }
    pieces = square_pieces.map{|square| square.piece }
    pieces
  end

  def player_pieces_names
    player_pieces.map{|piece| piece.name} 
  end

  def pinned_pieces
    player_pieces.select { |piece| piece.is_pinned? }
  end

  def pinned_pieces_names
    pinned_pieces.map { |piece| piece.name }
  end


end