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

        if @board.focused_piece
          if @board.focused_piece&.seen_squares&.include?(square)

            @board.focused_piece.move(square) 
            square.piece.reset_focus
            @board.change_player

          elsif square.piece&.color == @board.focused_piece.color

            @board.focused_piece.change_focus(square.piece)
            # @board.focused_piece.is_focused = false
            # square.piece.is_focused = true
            # @board.focused_piece = square.piece

          else     # fatorar esse métodos? tipo: reset_focused, algo do tipo
            @board.focused_piece = nil
          end

        elsif square.piece && square.piece.color == @board.current_player.color
          square.piece.is_focused = true
          @board.focused_piece = square.piece
        end
      end
    end
  end
end



