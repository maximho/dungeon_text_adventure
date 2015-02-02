class Dungeon
	attr_accessor :player

	def initialize(player_name)
		@player = Player.new(player_name)
		@rooms = []
	end

	def add_room(reference, name, description, connections)
		@rooms << Room.new(reference, name, description, connections)
	end

	def start(location)
		@player.location = location
		show_current_description
	end

	def show_current_description
		puts find_room_in_dungeon(@player.location).full_description
	end

	def find_room_in_dungeon(reference)
		@rooms.detect {|room| room.reference == reference}
	end

	def find_room_in_direction(direction)
		find_room_in_dungeon(@player.location).connections[direction]
	end

	def go(direction)
		puts "You go " + direction.to_s
		@player.location = find_room_in_direction(direction)
		show_current_description
	end 

	class Player
		attr_accessor :name, :location

		def initialize(new_name)
			@name = new_name
		end
	end

	class Room
		attr_accessor :reference, :name, :description, :connections

		def initialize(reference, name, description, connections)
			@reference = reference
			@name = name
			@description = description
			@connections = connections
		end

		def full_description
			@name + "\n\nYou are in " + @description
		end
	end
end

# Create the main dungeon object
my_dungeon = Dungeon.new("Fred Bloggs")
puts my_dungeon.player.name

# Add rooms to the dungeon
my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous cave", { :north => :chillcave, :south => :darkcave, :west => :largecave, :east => :smallcave })
my_dungeon.add_room(:smallcave, "Small Cave", "a small, claustrophobic cave", { :north => :chillcave, :south => :darkcave, :west => :largecave, :east => :smallcave })
my_dungeon.add_room(:darkcave, "Dark Cave", "a dark, terrorific cave", { :north => :chillcave, :south => :darkcave, :west => :largecave, :east => :smallcave })
my_dungeon.add_room(:chillcave, "Chill Cave", "a chill, comfy cave", { :north => :chillcave, :south => :darkcave, :west => :largecave, :east => :smallcave })
# Start the dungeon by placing the player in the large cave
#my_dungeon.start(:largecave)
puts "Welcome to the Dungeon Text Adventure !! Please tell me your starting location..\n(largecave, smallcave, darkcave or chillcave)"
my_location = gets.chomp.to_sym
my_dungeon.start(my_location)
#my_dungeon.show_current_description

puts "where do you want to go? \n(north, south, east or west)"
my_direction= gets.chomp.to_sym 

my_dungeon.go(my_direction)
#my_dungeon.go(:west)

#my_dungeon.go(:east)


