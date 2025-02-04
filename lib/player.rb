class Player
  
  attr_accessor :color, :pieces

  def initialize(board, color)
    @color = color
    @board = board
  end


  def king 
    @board.get_piece_by_name(:king)[color]
  end

  def all_seen_squares
    all = []
    player_pieces.each do |piece|
      all += piece.seen_squares 
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

  # def all_seen_squares
  #   all = []
  #   @board.squares.flatten.each do |square| 
  #     if square.piece
  #       all += square.piece.seen_squares if square.piece.color == @color
  #     end
  #   end
  #   all
  # end



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