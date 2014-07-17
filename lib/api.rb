class HeartApi
	include HTTParty
	require_relative 'card'

	attr_accessor :cards
	attr_reader :base_url

	def initialize
		@cards = []
		@base_url = 'http://hearthstoneapi.com/cards/'
		initialize_card
	end

	def initialize_card
		response = HTTParty.get(@base_url + 'findAll')
		for i in 0..response.length - 1
			name = response[i]['name']
			type = response[i]['type']
			set = response[i]['set']
			id_api = response[i]['id_api']
			cclass = response[i]['class']
			description = response[i]['description']
			quality = response[i]['quality']
			cost = response[i]['cost']
			health = response[i]['health']
			attack = response[i]['attack']
			@cards.push Card.new(name, type, set, id_api, cclass, description, quality, cost, health, attack)
		end
	end

	def get_cards
		@cards
	end

	def get_cards_by_set set
		@cards.select { |c| c.set == set }
	end

	def get_cards_by_cost low, high
		@cards.select { |c| c.cost >= low && c.cost <= high }
	end

end