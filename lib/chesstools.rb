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
end


