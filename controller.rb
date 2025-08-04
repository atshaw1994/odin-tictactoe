require "./game"

module TicTacToe
  class GameController
    def initialize
      welcome_screen
      game_loop
    end

    def welcome_screen #greets players, asks for names
      puts "|| Welcome to Tic Tac Toe! ||"
      puts "||-------------------------||\n"
      print "Enter Player 1's name: "
      @name1 = gets.chomp
      puts " "
      print "Enter Player 2's name: "
      @name2 = gets.chomp
      puts " "
    end

    def game_loop #loops between running the game and asking if user wants to play again
      game_start
      play_again
    end

    def game_start #creates and runs a game
      board = Board.new
      player1, player2 = Player.new(@name1), Player.new(@name2)
      Game.new(player1, player2, board)
    end

    def play_again #asks user if they want to play again
      input = nil
      until input == "Y" or input == "N"
        puts "Would you like to play again? (Y/N): "
        input = gets.chomp.upcase
      end
      case input
      when "Y"
        game_start
      when "N"
        puts "Thank you for playing!"
      end
    end
  end
end