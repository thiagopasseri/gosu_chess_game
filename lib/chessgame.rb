require 'gosu'

class ChessGame < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Meu Jogo com Gosu"
    self.update_interval = 42

    @board = Board.new
    

  end

  def draw
    @board.draw
  end

  def mouse_over_area?(x, y, width, height)
    mouse_x >= x && mouse_x <= x + width &&
      mouse_y >= y && mouse_y <= y + height
  end

  def needs_cursor?
    true  # Isso faz o cursor do mouse ficar visível
  end

  def button_down(button_id)
    case button_id
    when Gosu::KB_ESCAPE
      close

    when Gosu::KB_SPACE
      # @piece.move(@piece.seen_square([-1,0]))

    when Gosu::MS_LEFT # Verifica botão esquerdo do mouse
        manage_mouse_click

    else
      super
    end
  end

  def manage_mouse_click
    @board.squares.flatten.each do |square|
      if mouse_over_area?(*square.rect) 
        if @board.clicked_piece
          if @board.clicked_piece&.seen_squares&.include?(square)
            @board.clicked_piece.move(square) 
            square.piece.is_clicked = false
            @board.clicked_piece = nil
            @board.player_turn = @board.player_turn == :white ? :black : :white 
          elsif square.piece&.color == @board.clicked_piece.color
            @board.clicked_piece.is_clicked = false
            square.piece.is_clicked = true
            @board.clicked_piece = square.piece
          else     # fatorar esse métodos? tipo: reset_clicked, algo do tipo
            @board.clicked_piece.is_clicked = nil
            @board.clicked_piece = nil
          end
        elsif square.piece && square.piece.color == @board.player_turn
          square.piece.is_clicked = true
          @board.clicked_piece = square.piece
        end
      end
    end
  end
end



