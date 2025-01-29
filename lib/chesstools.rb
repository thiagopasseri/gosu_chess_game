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
    while (position[0] + direction[0] * step).between?(0,7) && (position[1] + direction[1] * step).between?(0,7)
      line << [position[0] + direction[0] * step, position[1] + direction[1] * step] 
      step += 1
    end
    line
  end


  # def self.get_double_diagonal(row, column)
  #   arr = [[row, column]]

  #   step = 1
  #   #esquerda cima
  #   while row - step >= 0 && column - step >= 0 do
  #     arr << [row - step, row - step, "a"]
  #     step += 1
  #   end   
    
  #   step = 1

  #   #direita baixo 
  #   while row + step <=7 && column + step <= 7 do
  #     arr << [row + step, column + step, "b"]
  #     step += 1
  #   end

  #   step = 1
  #   #esquerda baixo
  #   while row + step <= 7 && column - step >= 0 do
  #     arr << [row + step, column - step, "c"]
  #     step += 1
  #   end 

  #   step = 1
  #   #direita cima
  #   while row - step >= 0 && column + step <= 7 do
  #     arr << [row - step, column + step, "d"]
  #     step += 1
  #   end 
  #   arr
  # end



end


