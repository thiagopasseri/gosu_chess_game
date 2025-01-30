require_relative 'square'

module ChessTools
  
  def self.generate_squares(board)
    group = []
    8.times do |row|
      row_arr = []
      8.times do |col|
        row_arr << Square.new(row, col, board)
      end
      group << row_arr 
    end
    group
  end

  def self.draw_highlight_squares(squares)
    squares.each do |square|
      Gosu.draw_rect(
        square.position[0],
        square.position[1],
        SQUARE_SIZE,
        SQUARE_SIZE,
        Gosu::Color.rgba(200, 200, 200, 128),
        2,
        :default
      )
    end
  end
  
  def self.get_line_coord(position,direction) # vetor direção [i,j]
    line = []
    step = 1
    while (position[0] + direction[0] * step).between?(0,7) && (position[1] + direction[1] * step).between?(0,7) do
      line << [position[0] + direction[0] * step, position[1] + direction[1] * step] 
      step += 1
    end
    line
  end


  #pesquisar melhor forma de escrever esse while (pq nao da pra colocar numa variavel fora do while)
  
  def self.get_seen_line_coord(row, column, direction, board)
    line = []
    step = 1

    loop do
      current_row = row + direction[0] * step
      current_column = column + direction[1] * step

      break unless in_board?(current_row, current_column)
        
      current_piece = get_piece(current_row, current_column, board)
      initial_piece = get_piece(row, column, board)

      if current_piece
        if current_piece.color == initial_piece.color  
          break
        else
          line << [current_row, current_column] 
          break
        end
      else
        line << [current_row, current_column]
      end

      step += 1
    end

    line
  end
  
  def self.get_piece(row, column, board)
    board.squares[row][column]&.piece
  end


  def self.get_knight_moves_coord(row, column)
    arr = []
    [-2, 2].each do |big_step|
      [-1, 1].each do |small_step|
        # variables for taking the big step horizontaly or verticaly
        x_big_step_row = row + big_step
        x_big_step_column = column + small_step
        y_big_step_row = row + small_step
        y_big_step_column = column + big_step

        arr << [x_big_step_row, x_big_step_column] if in_board?(x_big_step_row, x_big_step_column)
        arr << [y_big_step_row, y_big_step_column] if in_board?(y_big_step_row, y_big_step_column)
      end
    end
    arr
  end

  def self.in_board?(row, column)
    row.between?(0,7) && column.between?(0,7)
  end


end


