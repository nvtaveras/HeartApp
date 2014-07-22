require 'api'


class HomeController < ApplicationController

	def welcome
	end

	def search
		# render :text => params.inspect
		@api_test = HeartApi.new
		
	end

	def results
		@card_api = HeartApi.new
		@filtered = []
		@filtered2 = []
		if params[:cost].present?
			@filtered = @card_api.get_cards_by_cost(0, params[:cost].to_i)
			@filtered2 = @card_api.get_cards_by_cost_optimized(params[:cost].to_i)
			flash[:notice] = "Your search returned #{@filtered2.length} results!"
		end
		@filtered2 = @filtered2.paginate(:page => params[:page],:per_page => 10)
	end

end
