# SQUARE_SIZE = 50
PADDING = 30


require_relative './lib/board'
require_relative './lib/chessgame'
require_relative './lib/player'

require_relative './config/resources'

game = ChessGame.new
game.show

