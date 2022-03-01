require_relative "../lib/piece"
require_relative "../lib/player"


class Board
    attr_accessor :grid, :p1, :p2, :current_player

    def initialize
        @grid = Array.new(8) { Array.new(8,  '_') }
        @p1 = Player.new('white')
        @p2 = Player.new('black')
        self.player_pieces(@p1)
        self.player_pieces(@p2)
        @current_player = @p1
    end

    def switch_turn
        if self.current_player == self.p1
            self.current_player = self.p2
        elsif self.current_player == self.p2
            self.current_player = self.p1
        end
    end

    def get_position
        puts "Player of the #{@current_player.color.to_s} pieces, enter the four digits you would like to play"
        digits = gets.chomp.split(' ').map(&:to_i)
        raise "Sorry that was invalid" if digits.length != 4
        digits
    end

    def print_board 
        p 'The Board'
        self.grid.each_with_index do |row, i|
            p row
        end
    end

    # def pretty_print_board
    #     self.grid.each_with_index do |row, i|
    #         if i%2==0 #row is even
    #             row.each_with_index do |square, i|
    #                 if i%2 == 0 #square is even
    #                     square = "\u25A0"
    #                 else 
    #                     square = "\u25A1"
    #                 end
    #             end
    #         else  #row is odd
    #             row.each_with_index do |square, i|
    #                 if i%2 == 0 #square is even
    #                     square = "\u25A1"
    #                 else 
    #                     square = "\u25A0"
    #                 end
    #             end
    #         end
    #     end
    #     self.player_pieces(p1)
    #     self.player_pieces(p2)
    #     self.print_board
    # end

    def player_pieces(player)
        player.pieces.each do |piece|
            self.grid[piece.position[0]][piece.position[1]] = piece.unicode
        end
    end


    def select_piece(row, col)
        @p1.pieces.each do |piece|
            if piece.position[0] == row && piece.position[1] == col
                return piece
            end
        end
        @p2.pieces.each do |piece|
            if piece.position[0] == row && piece.position[1] == col
                return piece
            end
        end
    end

    def move_piece(row,col,target_row,target_col)
        pce = select_piece(row, col)
        target = [target_row,target_col]
        if pce.class != Pawn
            if pce.possible_moves.include?(target) || pce.possible_moves == target
                if path_free?(pce.position, target) || pce.class == Knight
                    if target_free?(target[0],target[1])
                        former_pos = pce.position
                        pce.position = target
                        self.grid[former_pos[0]][former_pos[1]] = '_'
                    elsif target_enemy?(pce,target[0],target[1])
                        targ_pce = select_piece(target[0],target[1])
                        if targ_pce.color == 'white'
                            self.p1.pieces.delete(targ_pce)
                            self.p2.captured_pieces << targ_pce
                        else 
                            self.p2.pieces.delete(targ_pce)
                            self.p1.captured_pieces << targ_pce
                        end
                        targ_pce.position = nil #
                        former_pos = pce.position
                        pce.position = target
                        self.grid[former_pos[0]][former_pos[1]] = '_'
                    else
                        raise "No can do, breh."
                    end
                end
            end
        else #logic to deal with pawn movements including diagonal kills
            if pce.possible_moves == target || pce.possible_moves.include?(target) && target_free?(target_row, target_col) && path_free?(pce.position,target)
                former_pos = pce.position
                pce.position = target
                self.grid[former_pos[0]][former_pos[1]] = '_'
            elsif pawn_kill?(pce,target_row,target_col) && target_enemy?(pce, target_row, target_col)
                targ_pce = select_piece(target[0],target[1])
                if targ_pce.color == 'white'
                    self.p1.pieces.delete(targ_pce)
                    self.p2.captured_pieces << targ_pce
                else 
                    self.p2.pieces.delete(targ_pce)
                    self.p1.captured_pieces << targ_pce
                end
                targ_pce.position = nil
                former_pos = pce.position
                pce.position = target
                self.grid[former_pos[0]][former_pos[1]] = '_'
            end
        end
        self.player_pieces(p1)
        self.player_pieces(p2)
        pce.update_possible_moves
        if self.check? 
            print 'CHECK!'
        end
        self.print_board
    end

    def pawn_kill?(pce,target_row,target_col) #tells if target is killable by pawn [3,0] -> [4,1] - poss moves for [3,0] would be [4,0]
        pce.possible_moves.each do |possible_move|
            if possible_move[0] == target_row && possible_move[1]-1 == target_col|| possible_move[1]+1 == target_col
                return true
            end
        end
        return false
    end

    def path_free?(position, target)
        path = []

        if position[0] <= target [0] #establish start and finish
            start = position
            finish = target
        else 
            start = target
            finish = position
        end

        if start[0] == finish[0] #make path array / same row
            incrementer = (start[1]+1)
            ((finish[1]-start[1])-1).times do
                path << [start[0],incrementer]
                incrementer=incrementer+1
            end
        elsif start[1]==finish[1] #same column
            incrementer = (start[0]+1)
            ((finish[0]-start[0])-1).times do
                path << [incrementer, start[1]]
                incrementer=incrementer+1
            end
        else #diag
            incrementer = 1 
            ((finish[0]-start[0])-1).times do 
                path << [(start[0]+incrementer),(start[1]+incrementer)]
                incrementer=incrementer+1
            end
        end
        path.each do |coords|
            if self.grid[coords[0]][coords[1]] != '_'
                return false
            end
        end
        return true
    end

    def target_free?(r,c)
        self.grid[r][c] == '_'
    end

    def target_enemy?(piece, r,c)
        col = piece.color
        target_piece = self.select_piece(r,c)
        return col != target_piece.color
    end

    def select_king(player)
        player.pieces.each do |piece|
            if piece.class == King
                return piece
            end
        end
    end

    def check?
        if self.current_player == self.p1
            enemy_king = select_king(p2)
        else 
            enemy_king = select_king(p1)
        end
        magic_spot = enemy_king.position
        current_player.pieces.each do |piece|
            if piece.possible_moves.include?(magic_spot) || piece.possible_moves == magic_spot
                return true
            end
        end
        return false
    end

    

end