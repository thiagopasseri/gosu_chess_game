# SQUARE_SIZE = 50
PADDING = 30


require_relative './lib/board'
require_relative './lib/chessgame'
require_relative './lib/player'
require_relative './lib/menu'


require_relative './config/resources'

game = ChessGame.new
board = game.board
board.clear

board.squares[0][4].piece = King.new(board.squares[0][4])
board.squares[7][4].piece = King.new(board.squares[7][4])

# board.kings = {
#   white: board.get_piece_by_name(:king)[:white],
#   black: board.get_piece_by_name(:king)[:black]
# }

board.squares[1][4].piece = Queen.new(board.squares[1][4])
board.squares[6][4].piece = Queen.new(board.squares[6][4])

game.show

