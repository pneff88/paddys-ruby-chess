require_relative "../lib/piece"

class Player
    attr_accessor :color, :pieces, :captured_pieces

    def initialize(color)
        @color=color
        if color == 'black'
            @pieces = [
                Pawn.new('black',[6,0]),
                Pawn.new('black',[6,1]),
                Pawn.new('black',[6,2]),
                Pawn.new('black',[6,3]),
                Pawn.new('black',[6,4]),
                Pawn.new('black',[6,5]),
                Pawn.new('black',[6,6]),
                Pawn.new('black',[6,7]),
                Rook.new('black',[7,0]),
                Knight.new('black',[7,1]),
                Bishop.new('black',[7,2]),
                King.new('black',[7,3]),
                Queen.new('black',[7,4]),
                Bishop.new('black',[7,5]),
                Knight.new('black',[7,6]),
                Rook.new('black',[7,7])
            ]
        else
            @pieces = [
                Pawn.new('white',[1,0]),
                Pawn.new('white',[1,1]),
                Pawn.new('white',[1,2]),
                Pawn.new('white',[1,3]),
                Pawn.new('white',[1,4]),
                Pawn.new('white',[1,5]),
                Pawn.new('white',[1,6]),
                Pawn.new('white',[1,7]),
                Rook.new('white',[0,0]),
                Knight.new('white',[0,1]),
                Bishop.new('white',[0,2]),
                King.new('white',[0,3]),
                Queen.new('white',[0,4]),
                Bishop.new('white',[0,5]),
                Knight.new('white',[0,6]),
                Rook.new('white',[0,7])
            ]
        end
        @captured_pieces = []
    end
end