require 'pp'

    class GameOfLife

        attr_reader :world

        def initialize(seed)
            @world = seed
            @worldWithNeighbours = updateNeighbours
        end 

        def tick
            tmp = []
            return unless @worldWithNeighbours
            @worldWithNeighbours.each do |coordinate|
                if @world.include?(coordinate) 
                    tmp += [coordinate] if countTheNeighbours(coordinate).between?(2,3)
                else
                    tmp += [coordinate] if countTheNeighbours(coordinate) == 3
                end
            end
            @world = tmp
        end
            
        def countTheNeighbours(coordinate)
            sum = 0
            tmp = @world
            tmp -= [coordinate] if @world.include?(coordinate)
            tmp.each do |worldCoordinate|
                if (worldCoordinate[:x] - coordinate[:x]).abs <= 1
                    sum += 1 if (worldCoordinate[:y] - coordinate[:y]).abs <= 1
                end
            end
            sum
        end

        private
        def updateNeighbours
            @worldWithNeighbours = []
            @world.each do |coordinate|
                (-1).upto(1) do |xDiff|
                    (-1).upto(1) do |yDiff|
                        @worldWithNeighbours += [{:x => coordinate[:x] - xDiff,
                                                  :y => coordinate[:y] - yDiff}]
                    end
                end
            end
            @worldWithNeighbours.uniq
        end

    end