# Towers of Hanoi
# The Disk

require "Tower"

class Disk
	@size # usually 1, 2, or 3 #refactor# should be user given size 1-3 or 1-6 etc
	@tower
	
	def initialize( size )
		@size = size
	end
	
	# getSize Property
	def getSize() #refactor# use ruby-attr
		return @size
	end
	
	# size property
	def display( thickness = 1 ) #refactor# display responsibility shall be handled to somebodyelse.
		times1 = thickness*@size*2
		output = "="*times1
		puts output.to_s.center(10).chomp
	end
	
	# compare
	def isBigger?( disk )
		self.getSize > disk.getSize
	end
	
	def isSmaller?( disk )
		self.getSize < disk.getSize
	end
	
	def Equal?( disk )
		self.getSize == disk.getSize
	end
	
	def MovetoTower( tower )
		@tower = tower
	end
	
	def getTower() Tower
		@tower
	end
	
	def movable?()	
		self.getTower.Top == self
	end
end