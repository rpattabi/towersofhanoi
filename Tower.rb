# Towers of Hanoi
# The Tower

require "Disk"

	SOURCE 	= 0
	INTERM	= 1
	DEST		= 2
	
class Tower
	@bIsSource
	@bIsDest 	
	@bIsInterm
	@designation	
	@disks
	
	def initialize( designation )
		@designation = designation
		
		if designation == SOURCE
			@bIsSource = true
		else
			if designation == DEST
				@bIsDest = true
			else
				@bIsInterm = true
			end
		end
		
		@disks = []
	end
	
	def source?()
		@bIsSource
	end
	
	def dest?()
		@bIsDest
	end
	
	def intermediate?()
		@bIsInterm
	end
	
	def empty?()
		@disks.size <= 0
	end
	
	def done?()
		@disks.size == 3 #@designation == DEST and 
	end
	
	def AddDisk( disk )
		#if diskMovable?(disk) #or assert whichever is appropriate
			@disks.push( disk )
			disk.MovetoTower(self)
			#puts " Disk " + disk.getSize().to_s + " is moved to Tower #{@designation+1}"
		#end
	end
	
	def MoveTop()
		if not self.empty?
			@disks.pop
		end
	end
	
	def Top() Disk
		@disks.last
	end
	
	def display() Disk
		@disks.size.step(0,-1) { |i|
			@disks[i].display
		}
	end
	
	def diskMovable?(disk)
		self.empty? or ((self.Top != disk) and (disk.isSmaller?(self.Top)))
	end
end