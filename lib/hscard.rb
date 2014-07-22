class HSCard
	attr_accessor :name, :type, :set, :id_api, :class, :description, :quality, :cost, :health, :attack, :image_url

	def initialize name, type, set, id_api, cclass, description, quality, cost, health, attack, image_url
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
		@image_url = image_url
	end
end