require 'gosu'

class ChessGame < Gosu::Window

  attr_accessor :board

  def initialize
    super 840, 480
    self.caption = "Meu Jogo com Gosu"
    self.update_interval = 400

    @board = Board.new

    @game_state = :menu
    @main_menu = MainMenu.new(self)
  end

  def draw
    case @game_state
    when :menu
      @main_menu.draw
    when :game
      @board.draw
      @board.menu.draw
      # @board.play_next_move
    end
  end

  def update
    @main_menu.update if @game_state == :menu
  end

  def mouse_over_area?(x, y, width, height)
    mouse_x >= x && mouse_x <= x + width &&
      mouse_y >= y && mouse_y <= y + height
  end

  def needs_cursor?
    true  # Isso faz o cursor do mouse ficar visível
  end

  def button_down(button_id)
    case @game_state
    when :menu
      @main_menu.button_down(button_id)

    when :game
      case button_id
      when Gosu::KB_ESCAPE
        close
  
      when Gosu::KB_SPACE
  
      when Gosu::MS_LEFT # Verifica botão esquerdo do mouse
          manage_mouse_click
      else
        super
      end
    end
  end

  def start_new_game
    @board = Board.new
    @game_state = :game
  end

  def load_game(save_file)
    # Implemente aqui a lógica para carregar um jogo salvo
    file_content = File.read(File.join("saves", save_file))

    loaded_history = JSON.parse(file_content)
    @board = Board.new
    @board.play_all_history(loaded_history)
    @game_state = :game

  end

  def manage_mouse_click
    @board.squares.flatten.each do |square|
      if mouse_over_area?(*square.rect) 

        if @board.focused_piece
          if @board.focused_piece&.possible_moves&.include?(square)

            @board.focused_piece.move(square) 
            square.piece.reset_focus
            @board.change_player

          elsif square.piece&.color == @board.focused_piece.color

            @board.focused_piece.change_focus(square.piece)
          else     

            @board.focused_piece.turn_off_focus
          end

        elsif square.piece && square.piece.color == @board.current_player.color
          square.piece.is_focused = true
          @board.focused_piece = square.piece
        end
      end
    end
  end
end



