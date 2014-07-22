class MTGApi
	require 'httparty'
	require_relative 'mtgcard'

	attr_reader :base_url

	def initialize
		@base_url = 'http://api.mtgdb.info/'
	end

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

	def can_buy card, w, u, b, r, g
		# How much do i got of each type
		got = Hash.new
		got['W'] = w
		got['U'] = u
		got['B'] = b
		got['R'] = r
		got['G'] = g
		manacost = card.manacost
		idx = 0
		extra = 0 # Required extra cards                                                                                                                                                                                                                                           cxx
		while idx < manacost.length do
			if is_i?(manacost[idx])
				extra = extra * 10
				extra = extra + manacost[idx].to_i
			else
				# Decrement only if it exist
				if manacost[idx] == 'W' || manacost[idx] == 'U' || manacost[idx] == 'B' || manacost[idx] == 'R' || manacost[idx] == 'G'
					got[manacost[idx]] = got[manacost[idx]] - 1
				end
			end
			idx = idx + 1
		end
		f = 1 # set to 1 because right now i can buy the card
		got.each do |k, v|
			if v < 0
				f = 0 # takes more than what i have, can't buy.
			else
				extra = extra - v
			end
		end
		f == 1 && extra <= 0
	end

	def can_buy_from_set set_id, w, u, b, r, g
		cards = get_cards_by_set(set_id)
		res = []
		for i in 0..cards.length - 1
			res.push cards[i] if can_buy(cards[i], w, u, b, r, g) 
		end
		res
	end

	def get_card_by_id id
		request_url = @base_url + 'cards/' + id.to_s
		response = HTTParty.get(request_url)
		name = response['name']
		manacost = response['manaCost']
		description = response['description']
		MTGCard.new(id, name, manacost, description)
	end

	def get_card_manas manacost
		res = Hash.new
		res['W'] = 0
		res['U'] = 0
		res['B'] = 0
		res['R'] = 0
		res['G'] = 0
		while idx < manacost.length do
			if is_i?(manacost[idx])
				extra = extra * 10
				extra = extra + manacost[idx].to_i
			else
				# Decrement only if it exist
				if manacost[idx] == 'W' || manacost[idx] == 'U' || manacost[idx] == 'B' || manacost[idx] == 'R' || manacost[idx] == 'G'
					res[manacost[idx]] = res[manacost[idx]] + 1
				end
			end
			idx = idx + 1
		end
		res['E'] = extra
		res
	end

	def is_i? c
    c >= '0' && c <= '9'
  end

end
