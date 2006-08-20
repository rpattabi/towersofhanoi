require "Tower"
require "Disk"

class Player
	@towers
	@disks
	@direction
	@diskMover
	
	def initialize( towers, disks )
		@towers = towers
		@disks	= disks
		@diskMover = DiskMover.new()
		
		#@towers[SOURCE].display
		displayTowers #refactor# Display is not the job of the player.
	end
	
	def solve()
	   #refactor#direction should not be shown with magic numbers
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
		@diskMover.replay
	end
	
	def move( disk ) #refactor# command pattern
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
    		#move it to tmpTower
    	  @diskMover.move(Move.new(disk, disk.getTower, tmpTower))
    		displayTowers #refactor#
		end
	end
	
	def moveRight(disk)
		tmpTower = self.rightTower(disk.getTower)
		
		while not(tmpTower == disk.getTower and tmpTower.diskMovable?(disk))
			tmpTower = self.rightTower(tmpTower)
		end
		
		if tmpTower != disk.getTower
    		#move it to tmpTower
    	  @diskMover.move(Move.new(disk, disk.getTower, tmpTower))
    		displayTowers #refactor#
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
	
	def rightTower(tower) Tower
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


class DiskMover #invoker or the Player is invoker?
  def initialize()
    @moves = []
		#@curMove = NoMove.new
  end
  
  def move( move ) # >
    # log the movement
    @moves.push move
    move.execute

		#@curMove = move
  end
	
	def unmove() # <<
		#@moves.pop.undo
		#@curMove = @moves[@moves.size-2]
	end
	
	def redomove() # >>
		#@curMove.execute
	end
  
  def replay()
    @moves.each do |move|
      move.printMove
    end
  end 
end


class Move #command
  attr :disk
  attr :fromTower
  attr :toTower
  
  def initialize( disk, fromTower, toTower)
    @disk       = disk
    @fromTower  = fromTower
    @toTower    = toTower
  end

	def execute()
    # first remove the disk from the tower it is on
    @fromTower.MoveTop
		
		# move the disk to toTower
    @toTower.AddDisk @disk  
	end
	
	def undo()
		@toTower.MoveTop
		@fromTower.AddDisk @disk
	end
	
	def log( file )
		file.append "\n" + " Disk " + @disk.getSize.to_s +
         " is moved from Tower " + @fromTower.designation.to_s +
         " to Tower " + @toTower.designation.to_s
	end
	
  def printMove()
    puts "\n" + " Disk " + @disk.getSize.to_s +
         " is moved from Tower " + @fromTower.designation.to_s +
         " to Tower " + @toTower.designation.to_s
  end
end

class NoMove #null object
  def initialize( disk, fromTower, toTower)
  end
	
	def initialize()
	end

	def execute()
	end
	
	def undo()
	end
	
	def log( file )
	end
	
  def printMove()
  end
end
