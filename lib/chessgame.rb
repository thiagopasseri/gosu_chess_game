require 'gosu'

class ChessGame < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Meu Jogo com Gosu"
    @board = Board.new
    @piece = @board.squares[6][0].piece
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
      # @board.squares[6][0].piece.move(@board.squares[5][0])
      @piece.move(@piece.seen_square([-1,0]))

    when Gosu::MS_LEFT # Verifica botão esquerdo do mouse
      @board.squares.flatten.each do |square|
        if mouse_over_area?(*square.rect)
          if @board.clicked_piece
            puts "teste"
            @board.clicked_piece.move(square)
            square.piece.is_clicked = false
            @board.clicked_piece = nil
          else
            if square.piece&.is_clicked
              square.piece.is_clicked = false
              @board.clicked_piece = nil
            elsif square.piece
              square.piece.is_clicked = true 
              @board.clicked_piece = square.piece
            end
          end

        end
      end
    else
      super
    end
  end

end



