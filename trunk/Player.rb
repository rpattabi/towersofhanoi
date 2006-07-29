require "Tower"
require "Disk"

class Player
	@towers
	@disks
	@direction
	@currentTower
	@currentDisk
	@nextTower
	
	def initialize( towers, disks )
		@towers = towers
		@disks	= disks
		
		#@towers[SOURCE].display
		displayTowers
	end
	
	def solve()
		if (@disks.size%2 == 0)
			@direction = 1
		else
			@direction = -1
		end
		
		#puts @towers
		
		while not @towers[DEST].done?()
			@disks.each do |disk|			
				if disk.movable? 
					move(disk) 
				end
			end
		end

		#@towers[DEST].display
	end
	
	def move( disk )
			if @direction == -1
				moveLeft( disk )
			else
				moveRight( disk )
			end
	end
	
	def moveLeft(disk)
		tmpTower = self.leftTower(disk.getTower)
		
		while (tmpTower != disk.getTower) and (not tmpTower.diskMovable?(disk))
			tmpTower = self.leftTower(tmpTower)
		end
		
		if tmpTower != disk.getTower
			disk.getTower.MoveTop
			tmpTower.AddDisk(disk)
								displayTowers
		end
	end
	
	def moveRight(disk)
		tmpTower = self.rightTower(disk.getTower)
		
		while not(tmpTower == disk.getTower and tmpTower.diskMovable?(disk))
			tmpTower = self.rightTower(tmpTower)
		end
		
		if tmpTower != disk.getTower
			disk.getTower.MoveTop		
			tmpTower.AddDisk(disk)
					displayTowers			
		end
	end
	
	def leftTower(tower) Tower
		if tower.source?
			return @towers[DEST]
		end
		
		if tower.dest?
			return @towers[INTERM]
		end
		
		return @towers[SOURCE]
	end
	
	def rightTower(tower)
		if tower.source?
			return @towers[INTERM]
		end
		
		if tower.dest?
			return @towers[SOURCE]
		end
		
		return @towers[DEST]	
	end
	
	def displayTowers()
					
				#puts '000000000000000000'	
				@towers[SOURCE].display
				puts "SOURCE"
				puts "\n"*2
				
				@towers[INTERM].display
				puts "INTERM"
				puts "\n"*2

				@towers[DEST].display
				puts "DEST"
				#puts "\n"*3
				puts '000000000000000000'
				puts "\n"*4
		end
end