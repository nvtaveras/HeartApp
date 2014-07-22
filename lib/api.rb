class HeartApi
	include HTTParty
	require_relative 'card'

	attr_accessor :cards, :cards_sorted
	attr_reader :base_url, :base_image_url

	def initialize
		@cards = []
		@base_url = 'http://hearthstoneapi.com/cards/'
		@base_image_url = 'https://api.myjson.com/bins/36b0c'
		# @base_image_url = 'http://localhost:3000/assets/cards_images.json'
		initialize_card
		@cards_sorted = @cards.sort_by{ |c| c.cost.to_i}
		
	end

	def initialize_card
		response = HTTParty.get(@base_url + 'findAll')

		# Set the url for each image from a local json file
		images_link = Hash.new
		images_response = HTTParty.get(@base_image_url)
		for i in 0..images_response.length - 1
			images_link[ images_response[i]['name'] ] = images_response[i]['image_url']
		end
		
		for i in 0..response.length - 1
			name = response[i]['name']
			type = response[i]['type']
			set = response[i]['set']
			id_api = response[i]['id']
			cclass = response[i]['classs']
			description = response[i]['description']
			quality = response[i]['quality']
			cost = response[i]['cost'].to_i
			health = response[i]['health']
			attack = response[i]['attack']
			image_url = images_link[name]
			if attack.nil?
				attack = "-"
			end
			if health.nil?
				health = "-"
			end
			if description.nil?
				description = "-"
			end
			@cards.push Card.new(name, type, set, id_api, cclass, description, quality, cost, health, attack, image_url)
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

	def get_cards_by_cost_optimized cost
		low = 0
		high = @cards_sorted.length - 1
		cost = cost.to_i

		while low < high do
		    mid = low + (high-low+1)/2    

	        if  @cards_sorted[mid].cost.to_i > cost
		    	high = mid-1
		    else
		    	low = mid
	     	end
	    end

	    @cards_sorted[0..low]
	end

end
