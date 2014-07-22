require 'api'


class HomeController < ApplicationController

	$card_api = HeartApi.new
	
	def welcome
	end

	def search
		# render :text => params.inspect		
	end

	def cardinfo
<<<<<<< HEAD
		# @card_api = HeartApi.new
		# @card = @card_api.get_cards.find{ |x| x.id_api == params[:id_api].to_i}
=======
		@card = $card_api.get_cards.find{ |x| x.id_api == params[:id_api].to_i}
>>>>>>> 3fb190860c8562d6313db06c506d3964996f238c
	end

	def results
		@filtered = []
		@filtered2 = []
		if params[:cost].present?
			@filtered = $card_api.get_cards_by_cost(0, params[:cost].to_i)
			@filtered2 = $card_api.get_cards_by_cost_optimized(params[:cost].to_i)
			flash.now[:notice] = "Your search returned #{@filtered2.length} results!"
		end
		@filtered2 = @filtered2.paginate(:page => params[:page],:per_page => 10)
	end

end
