class HeartApi
	require 'HTTParty'
	require_relative 'mtgcard'

	attr_reader :base_url

	def initialize
		@base_url = 'http://api.mtgdb.info/'
	end

	# def initialiaze_cards
	# 	response = HTTParty.get(@base_url + 'cards')
	# end

	def get_cards_by_set set_id
		request_url = @base_url + 'sets/' + set_id + '/cards'
		response = HTTParty.get(request_url)
		cards = []
		for i in 0..response.length - 1
			id = response[i]['id']
			name = response[i]['name']
			manacost = response[i]['manaCost']
			description = response[i]['description']
			cards.push MTGCard.new(id, name, manacost, description)
		end
		cards
	end

end