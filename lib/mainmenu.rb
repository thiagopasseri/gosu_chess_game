class MainMenu
  SELECTED_COLOR = Gosu::Color::YELLOW
  UNSELECTED_COLOR = Gosu::Color::WHITE
  
  def initialize(window)
    @window = window
    @font = Gosu::Font.new(30)
    @selected_option = 0
    @options = ['NEW GAME', 'LOAD GAME']
    @showing_saves = false
    @save_files = []
    @selected_save = 0
  end

  def draw
    if @showing_saves
      draw_save_files
    else
      draw_main_options
    end
  end

  def draw_main_options
    @options.each_with_index do |option, index|
      color = index == @selected_option ? SELECTED_COLOR : UNSELECTED_COLOR
      x = center_x(option)
      y = 200 + index * 50
      @font.draw_text(option, x, y, 1, 1.0, 1.0, color)
    end
  end

  def draw_save_files
    @save_files.each_with_index do |file, index|
      color = index == @selected_save ? SELECTED_COLOR : UNSELECTED_COLOR
      x = center_x(file)
      y = 200 + index * 50
      @font.draw_text(file, x, y, 1, 1.0, 1.0, color)
    end
    
    # Draw back option
    back_text = "BACK"
    color = @selected_save == @save_files.length ? SELECTED_COLOR : UNSELECTED_COLOR
    x = center_x(back_text)
    y = 200 + @save_files.length * 50
    @font.draw_text(back_text, x, y, 1, 1.0, 1.0, color)
  end

  def update
    if @showing_saves && @save_files.empty?
      load_save_files
    end
  end

  def button_down(id)
    case id
    when Gosu::KB_UP
      if @showing_saves
        @selected_save = (@selected_save - 1) % (@save_files.length + 1)
      else
        @selected_option = (@selected_option - 1) % @options.length
      end
    when Gosu::KB_DOWN
      if @showing_saves
        @selected_save = (@selected_save + 1) % (@save_files.length + 1)
      else
        @selected_option = (@selected_option + 1) % @options.length
      end
    when Gosu::KB_RETURN, Gosu::KB_SPACE
      handle_selection
    when Gosu::KB_ESCAPE
      if @showing_saves
        @showing_saves = false
        @selected_save = 0
      end
    end
  end

  def handle_selection
    if @showing_saves
      if @selected_save == @save_files.length # Back option
        @showing_saves = false
        @selected_save = 0
      else
        selected_file = @save_files[@selected_save]
        @window.load_game(selected_file) if selected_file
      end
    else
      case @selected_option
      when 0 # NEW GAME
        @window.start_new_game
      when 1 # LOAD GAME
        @showing_saves = true
      end
    end
  end

  def load_save_files
    save_dir = "saves" # ou o diretório que você definir
    @save_files = Dir.glob("#{save_dir}/*").map { |f| File.basename(f) }
  end

  private

  def center_x(text)
    (@window.width - @font.text_width(text)) / 2
  end
end