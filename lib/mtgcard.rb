class MTGCard
	attr_accessor :id, :name, :manacost, :description

	def initialize id, name, manacost, description
		@id = id
		@name = name
		@manacost = manacost
		@description = description
	end
end