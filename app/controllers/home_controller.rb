require 'api'

class HomeController < ApplicationController

	def welcome
	end

	def search
		# render :text => params.inspect
		@card_api = HeartApi.new
		@filtered = @card_api.get_cards_by_cost(0, params[:cost].to_i)
		@filtered2 = @card_api.get_cards_by_cost_optimized(params[:cost].to_i)
	end

end
