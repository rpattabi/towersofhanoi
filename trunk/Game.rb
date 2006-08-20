#Towers of Hanoi Game

#refactor#This could be unit test class.

require "Tower"
require "Disk"
require "Player"

puts "Setting up the puzzle..."

#Create disks
disks 	= [Disk.new(1), Disk.new(2), Disk.new(3)]
towers 	= [Tower.new(SOURCE), Tower.new(INTERM), Tower.new(DEST)] 

towers[SOURCE].AddDisk(disks[2])
towers[SOURCE].AddDisk(disks[1])
towers[SOURCE].AddDisk(disks[0])

puts "Solving..."
player = Player.new( towers, disks )
player.solve()

