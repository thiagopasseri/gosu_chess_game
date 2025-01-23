require 'gosu'

class ChessGame < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Meu Jogo com Gosu"
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
      @piece.move(@piece.seen_square([-1,0]))

    when Gosu::MS_LEFT # Verifica botão esquerdo do mouse
        manage_mouse_click

    else
      super
    end
  end

  def manage_mouse_click
    @board.squares.flatten.each do |square|
      if mouse_over_area?(*square.rect)
        puts "board.clicked_piece: #{@board.clicked_piece.class} -possible_moves: #{@board.clicked_piece&.possible_moves} "
        if @board.clicked_piece
          if @board.clicked_piece&.possible_moves&.include?(square)
            @board.clicked_piece.move(square) 
            square.piece.is_clicked = false
            @board.clicked_piece = nil
          elsif square.piece
            @board.clicked_piece.is_clicked = false
            square.piece.is_clicked = true
            @board.clicked_piece = square.piece
          else
            square.piece.is_clicked = false if square.piece
            @board.clicked_piece = nil
          end
        elsif square.piece
          square.piece.is_clicked = true
          @board.clicked_piece = square.piece
        end
      end
    end
  end

  #fazer essa logica pro click passar de uma peça pra outra

  

end



