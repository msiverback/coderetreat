require_relative("../src/gameOfLife.rb")

describe "gameoflife" do	
    describe "init and tick " do 
        context "when started with and empty seed" do
            game = GameOfLife.new([])
            it "shall return an empty world" do
                expect(game.world()).to eq []
            end
            it "shall return an emty world after a tick" do
                game.tick
                expect(game.world()).to eq []
            end
        end

        context "when started with a single coordinate" do
            game = GameOfLife.new([{:x => 1, :y => 2}])
            it "shall die after one tick" do
                game.tick
                expect(game.world()).to eq []
            end
        end

        context "when started with two neightbours" do
            game = GameOfLife.new([{:x => 1, :y => 2}, {:x => 2, :y => 1}, {:x => 3, :y => 2}])

            it "shall stay alive after one tick" do
                game.tick
                expect(game.world.include?({:x => 2, :y => 1})).to eq true
            end
        end

        context "when started with one neighbour" do
            game = GameOfLife.new([{:x => 1, :y => 2}, {:x => 2, :y => 1}, {:x => 3, :y => 2}])
            it "shall die one tick" do
                game.tick
                expect(game.world.include?({:x => 1, :y => 2})).to eq false
                expect(game.world.include?({:x => 3, :y => 2})).to eq false
            end
        end

        context "a dead cell has 3 neighbours" do
            it "shall come alive" do
                game = GameOfLife.new([{:x => 1, :y => 2}, {:x => 2, :y => 1}, {:x => 3, :y => 2}])
                game.tick
                expect(game.world.include?({:x => 2, :y => 2})).to eq true
            end
        end
    end

    describe "countTheNeighbours" do
        game = GameOfLife.new([{:x => 1, :y => 2}, {:x => 2, :y => 1}, {:x => 3, :y => 2}])
        it "shall return 1 for the first coordinate" do
            expect(game.countTheNeighbours({:x => 1, :y => 2})).to eq 1
        end
        it "shall return 2 for the second coordinate" do
            expect(game.countTheNeighbours({:x => 2, :y => 1})).to eq 2
        end
        it "shall return 3 for [2,2]" do
            expect(game.countTheNeighbours({:x => 2, :y => 2})).to eq 3
        end
    end

    describe "end test" do
        it "blinker shall blink" do
            horizontal = [{:x => 1, :y => 2}, {:x => 2, :y => 2}, {:x => 3, :y => 2}]
            vertical = [{:x => 2, :y => 1}, {:x => 2, :y => 2}, {:x => 2, :y => 3}]
            game = GameOfLife.new(horizontal)
            game.tick
            expect(game.world - vertical).to eq []
            game.tick
            expect(game.world - horizontal).to eq []
            game.tick
            expect(game.world - vertical).to eq []
        end
    end
        

end
