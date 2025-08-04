module TicTacToe
  class Board
    attr_reader :spaces

    def initialize
      @spaces = [[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]]
    end

    def get_board
      board_string = ""
      # Loop through each row of the spaces array
      @spaces.each_with_index do |row, i|
        # Add the current row to the board, joined by "|"
        board_string << row.join(" | ")
        # Add a separator line if it's not the last row
        if i < @spaces.length - 1
          board_string << "\n" + "-" * 9 + "\n"
        end
      end
      board_string
    end

    def print_board()
      puts get_board()
    end

    def place_mark(mark)
      row = nil
      col = nil

      # Keep asking for input until a valid move is made.
      loop do
        print "Row: "
        row_str = gets.chomp
        print "Column: "
        col_str = gets.chomp

        row = row_str.to_i
        col = col_str.to_i

        # Check for all conditions at once.
        if row.between?(1, 3) && col.between?(1, 3) && @spaces[row - 1][col - 1] == " "
          break # Exit the loop if the input is valid.
        end

        # If the loop hasn't broken, the input was invalid.
        puts "Invalid input. The row and column must be between 1 and 3, and the space must be empty. Try again."
      end

      # Place the mark only after the loop has been exited.
      @spaces[row - 1][col - 1] = mark
      return true
    end
  end
end