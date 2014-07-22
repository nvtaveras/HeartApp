require 'heart_api'


class HomeController < ApplicationController

	$card_api = HeartApi.new
	
	def welcome
	end

	def searchhs
		# render :text => params.inspect		
	end

	def cardinfohs
		@card = $card_api.get_cards.find{ |x| x.id_api == params[:id_api].to_i}
	end

	def resultshs
		@filtered = []
		@filtered2 = []
		
		@filtered = $card_api.get_cards_by_cost(0, params[:cost].to_i)
		@filtered2 = $card_api.get_cards_by_cost_optimized(params[:cost].to_i)
		

		if params[:classes].present?
			@filtered = @filtered.select{ |card| card.class == params[:classes]}
			@filtered2 = @filtered2.select{ |card| card.class == params[:classes]}
		end

		flash.now[:notice] = "Your search returned #{@filtered2.length} results!"

		@filtered2 = @filtered2.paginate(:page => params[:page],:per_page => 10)
	end
end
