class Card
	attr_accessor :name, :type, :set, :id_api, :class, :description, :quality, :cost, :health, :attack

	def initialize name, type, set, id_api, cclass, description, quality, cost, health, attack
		@name = name
		@type = type
		@set = set
		@id_api = id_api
		@class = cclass
		@description = description
		@quality = quality
		@cost = cost
		@health = health
		@attack = attack
	end
end