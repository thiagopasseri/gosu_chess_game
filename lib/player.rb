class Player
  
  attr_accessor :color, :pieces, :king

  def initialize(board, color)
    @color = color
    @board = board
    @king = board.get_piece_by_name(:king)[color]
    @pieces = player_pieces
  end


  def all_seen_squares
    all = []
    @board.squares.flatten.each do |square| 
      if square.piece
        all += square.piece.seen_squares if square.piece.color == @color
      end
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


end