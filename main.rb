# SQUARE_SIZE = 50
PADDING = 30


require_relative './lib/board'
require_relative './lib/chessgame'
require_relative './lib/player'
require_relative './lib/menu'
require_relative './lib/mainmenu'
require 'json'


require_relative './config/resources'

game = ChessGame.new
board = game.board
# board.clear

# board.squares[0][4].piece = King.new(board.squares[0][4])
# board.squares[7][4].piece = King.new(board.squares[7][4])

# board.squares[1][4].piece = Queen.new(board.squares[1][4])
# board.squares[6][4].piece = Queen.new(board.squares[6][4])

history = [[[6, 3], [4, 3]], [[1, 3], [3, 3]], [[6, 4], [4, 4]], [[0, 2], [3, 5]], [[7, 3], [3, 7]], [[0, 1], [2, 2]], [[7, 1], [5, 2]], [[0, 3], [2, 3]], [[7, 5], [3, 1]]]
# board.play_all_history(history)
board.current_history = history

game.show

