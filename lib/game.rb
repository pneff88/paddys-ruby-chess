require_relative "../lib/board"


class Game
    attr_accessor :winner, :my_board, :game_over

    def initialize
        @game_over = false
        @winner = nil
        @my_board = Board.new
    end

    def play
        while !game_over
            pos = @my_board.get_position
            @my_board.move_piece(pos[0],pos[1],pos[2],pos[3])
            @my_board.switch_turn
        end
        Puts "The game is over. The player of the #{@winner.color} pieces is the winner!"
    end 
    def save

    end

    def load

    end

end