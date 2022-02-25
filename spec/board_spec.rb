require_relative "../lib/board"

describe Board do

    context "when using default initialization" do
    subject(:default_board) { Board.new }
        
        it "has eight rows" do
            expect(default_board.grid.length).to eq(8)
        end  

        it "has eight columns" do
            expect(default_board.grid[0].length).to eq(8)
        end
    end

    describe "#target_free?" do
        context "5,5 when default board/free" do
        subject(:default_board) { Board.new }
            it 'returns true' do
                expect(default_board.target_free?(5,5)).to eq(true)
            end
        end
        context "5,5 when not free" do
        subject(:default_board) { Board.new }
            it 'returns false' do
                default_board.grid[5][5] = 'X'
                expect(default_board.target_free?(5,5)).to eq(false)
            end
        end
    end

    describe "#path_free?" do
        context "when 00 -> 04 has obstacles" do
        subject(:default_board) { Board.new }
            it "returns false" do
                expect(default_board.path_free?([0,0],[0,4])).to eq(false)
            end
        end
        context "when 2-0 -> 2-4 does not have obstacles" do
        subject(:default_board) { Board.new }
            it 'returns true' do
                expect(default_board.path_free?([2,0],[2,4])).to eq(true)
            end
        end
        context "when 2-0 -> 4-2 with no obstacles" do 
        subject(:default_board) { Board.new }
            it 'returns true' do
                expect(default_board.path_free?([2,0],[4,2])).to eq(true)
            end
        end
        context "when 2-0 -> 4-2 with obstacles" do
        subject(:default_board) { Board.new }
            it 'returns false' do
                default_board.grid[3][1] = 'X'
                expect(default_board.path_free?([2,0],[4,2])).to eq(false)
            end
        end
        context "when 2-0 -> 4-2 with obstacles" do
        subject(:default_board) { Board.new }
            it 'returns false' do
                default_board.grid[3][1] = 'X'
                expect(default_board.path_free?([2,0],[4,2])).to eq(false)
            end
        end
        context "when 2-0 -> 4-2 with obstacle in 4-2" do
        subject(:default_board) { Board.new }
            it 'returns false' do
                default_board.grid[4][2] = 'X'
                expect(default_board.path_free?([2,0],[4,2])).to eq(true)
            end
        end
        context "when 2-0 -> 2-6 with obstacle in 2-6" do
        subject(:default_board) { Board.new }
            it 'returns false' do
                default_board.grid[2][6] = 'X'
                expect(default_board.path_free?([2,0],[2,6])).to eq(true)
            end
        end
        context "when 2-0 -> 5-0 with obstacle in 5-0" do       
        subject(:default_board) { Board.new }
            it 'returns false' do
                default_board.grid[5][0] = 'X'
                expect(default_board.path_free?([2,0],[5,0])).to eq(true)
            end
        end
        context "when 2-0 -> 3-0 with no obstacles" do       
        subject(:default_board) { Board.new }
            it 'returns true' do
                expect(default_board.path_free?([2,0],[3,0])).to eq(true)
            end
        end
    end



end


