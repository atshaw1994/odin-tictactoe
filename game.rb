require "./board.rb"
require "./player.rb"

module TicTacToe
  class Game
    attr_accessor :player1, :player2, :turn, :board

    @@winning_positions = [
      # Horizontal wins
      [[0, 0], [0, 1], [0, 2]],
      [[1, 0], [1, 1], [1, 2]],
      [[2, 0], [2, 1], [2, 2]],
      
      # Vertical wins
      [[0, 0], [1, 0], [2, 0]],
      [[0, 1], [1, 1], [2, 1]],
      [[0, 2], [1, 2], [2, 2]],
      
      # Diagonal wins
      [[0, 0], [1, 1], [2, 2]],
      [[0, 2], [1, 1], [2, 0]]
    ]

    def initialize(player1, player2, board)
      ##initialize external objects utilized by this class.
      @player1 = player1
      @player2 = player2
      @board = board

      ##initialize data for current game run
      @current_turn = 1
      @first_turn = ""
      @winner = ""

      #executes game flow
      play
    end

    def play #main flow of game
      pick_first_turn
      allocate_symbols
      take_turns
    end

    private

    def pick_first_turn #a player is randomly chosen to go first
      random = Random.new
      first_turn = random.rand(0..1)
      case first_turn
      when 0
        @first_turn = @player1.name
      when 1
        @first_turn = @player2.name
      end
      puts "#{@first_turn} goes first!\n"
    end

    def allocate_symbols #allocates the symbols to the players
      @player1.sym = "X"
      @player2.sym = "O"
    end

    def take_turns #take turns(loops) between the players depending on who started first and the current turn number
      until draw? || @winner != ""
        if @first_turn == @player1.name
          (@current_turn.even?) ? turn(@player2) : turn(@player1)
        elsif @first_turn == @player2.name
          (@current_turn.even?) ? turn(@player1) : turn(@player2)
        end
      end
      puts "Game was a draw!" if draw? #checks if game is a draw after loop ends
    end

    def turn(player) #one turn for a player
      puts "---------------------------\n"
      puts "Turn #{@current_turn}:"
      puts "---------------------------\n"
      @board.print_board
      @board.place_mark(player.sym)
      if check_winner(player)
        # The game is over, and the winner has been announced.
        # You would typically end the turn-taking loop here.
        return true
      end

      # If there is no winner, check for a draw
      if draw?
        # The game is a draw, you can announce that and end the loop.
        return true
      end

      # The turn ends, and the loop continues to the next player
      @current_turn += 1
      return false
    end

    def draw? #checks if the game is a draw
      (@current_turn == 9) && (@winner == "")
    end

    def check_winner(player)
      @@winning_positions.each do |triplet|
        if triplet.all? { |row, col| @board.spaces[row][col] == player.sym }
          @winner = player
          announce_win(player) # Call announce_win only once, from here.
          return true # End the check.
        end
      end
      false # No winner found.
    end

    def announce_win(player)
      puts "---------------------------"
      @board.print_board
      puts "Congratulations, #{player.name}! You win!"
    end
  end
end