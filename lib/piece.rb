class Pawn 
    attr_reader :color 
    attr_accessor :position, :unicode, :possible_moves

    def initialize(color, position)
        @position=position
        @color=color
        if color == 'black'
            @unicode = "\u2659"
        elsif color == 'white'
            @unicode = "\u265F"
        end
        @possible_moves = []
        update_possible_moves
    end

    def update_possible_moves
        if self.color == 'white'
            if self.position[0] == 1 #we're in startingposition
                self.possible_moves = [[2,self.position[1]], [3,self.position[1]]]
            else
                self.possible_moves = [(self.position[0]+1),self.position[1]]
            end
        else
            if self.position[0] == 6
               self.possible_moves = [[5,self.position[1]], [4,self.position[1]]]
            else
                self.possible_moves = [(self.position[0]-1),self.position[1]]
            end   
        end
    end

end

class Rook
    attr_reader :color 
    attr_accessor :position, :unicode, :possible_moves

    def initialize(color, position)
        @position=position
        @color=color
        if color == 'black'
            @unicode = "\u2656"
        elsif color == 'white'
            @unicode = "\u265C"
        end
        @possible_moves = []
        update_possible_moves
    end

    def update_possible_moves
        self.possible_moves = [
            [self.position[0],0],[self.position[0],1],[self.position[0],2],[self.position[0],3],
            [self.position[0],4],[self.position[0],5],[self.position[0],6],[self.position[0],7],
            [0,self.position[1]],[1,self.position[1]],[2,self.position[1]],[3,self.position[1]],
            [4,self.position[1]],[5,self.position[1]],[6,self.position[1]],[7,self.position[1]]
        ]
    end
end

class Knight
    attr_reader :color 
    attr_accessor :position, :unicode, :possible_moves

    def initialize(color, position)
        @position=position
        @color=color
        if color == 'black'
            @unicode = "\u2658"
        elsif color == 'white'
            @unicode = "\u265E"
        end
        @possible_moves = []
        update_possible_moves
    end

    def update_possible_moves
        self.possible_moves=[]
        row = self.position[0]
        col = self.position[1]
        self.possible_moves << [(row+1),(col+2)]
        self.possible_moves << [(row+2),(col+1)]
        self.possible_moves << [(row-1),(col+2)]
        self.possible_moves << [(row-2),(col+1)]
        self.possible_moves << [(row+1),(col-2)]
        self.possible_moves << [(row+2),(col-1)]
        self.possible_moves << [(row-1),(col-2)]
        self.possible_moves << [(row-2),(col-1)]
    end
end

class Bishop
    attr_reader :color 
    attr_accessor :position, :unicode, :possible_moves

    def initialize(color, position)
        @position=position
        @color=color
        if color == 'black'
            @unicode = "\u2657"
        elsif color == 'white'
            @unicode = "\u265D"
        end
        @possible_moves = []
        update_possible_moves
    end

    def update_possible_moves
        self.possible_moves=[]
        row = self.position[0]
        col = self.position[1]
        until row==0 || col ==0 do
            row = row-1
            col = col-1
            self.possible_moves << [row, col]
        end
        row = self.position[0]
        col = self.position[1]
        until row==0 || col ==7 do
            row = row-1
            col = col+1
            self.possible_moves << [row, col]
        end
        row = self.position[0]
        col = self.position[1]
        until row==7 || col ==7 do
            row = row+1
            col = col+1
            self.possible_moves << [row, col]
        end
        row = self.position[0]
        col = self.position[1]
        until row==7 || col ==0 do
            row = row+1
            col = col-1
            self.possible_moves << [row, col]
        end
    end
end

class Queen
    attr_reader :color 
    attr_accessor :position, :unicode, :possible_moves

    def initialize(color, position)
        @position=position
        @color=color
        if color == 'black'
            @unicode = "\u2655"
        elsif color == 'white'
            @unicode = "\u265B"
        end
        @possible_moves = []
        update_possible_moves
    end

    def update_possible_moves
        self.possible_moves = [
            [self.position[0],0],[self.position[0],1],[self.position[0],2],[self.position[0],3],
            [self.position[0],4],[self.position[0],5],[self.position[0],6],[self.position[0],7],
            [0,self.position[1]],[1,self.position[1]],[2,self.position[1]],[3,self.position[1]],
            [4,self.position[1]],[5,self.position[1]],[6,self.position[1]],[7,self.position[1]]
        ]
        row = self.position[0]
        col = self.position[1]
        until row==0 || col ==0 do
            row = row-1
            col = col-1
            self.possible_moves << [row, col]
        end
        row = self.position[0]
        col = self.position[1]
        until row==0 || col ==7 do
            row = row-1
            col = col+1
            self.possible_moves << [row, col]
        end
        row = self.position[0]
        col = self.position[1]
        until row==7 || col ==7 do
            row = row+1
            col = col+1
            self.possible_moves << [row, col]
        end
        row = self.position[0]
        col = self.position[1]
        until row==7 || col ==0 do
            row = row+1
            col = col-1
            self.possible_moves << [row, col]
        end
    end
end

class King 
    attr_reader :color 
    attr_accessor :position, :unicode, :possible_moves

    def initialize(color, position)
        @position=position
        @color=color
        if color == 'black'
            @unicode = "\u2654"
        elsif color == 'white'
            @unicode = "\u265A"
        end
        @possible_moves = []
        update_possible_moves
    end

    def update_possible_moves
        row=self.position[0]
        col=self.position[1]
        self.possible_moves=[
            [(row-1),(col-1)],
            [(row-1),(col)],
            [(row-1),(col+1)],
            [(row),(col-1)],
            [(row-1),(col+1)],
            [(row+1),(col-1)],
            [(row+1),(col)],
            [(row+1),(col+1)],
        ]
    end
end
