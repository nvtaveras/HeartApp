require 'magic_api'

class MtgController < ApplicationController

	def searchmtg
	
	end

	def cardinfomtg

	end

	def resultsmtg
		@mtg_api = MTGApi.new
		@filtered = []
		
		@filtered = @mtg_api.can_buy_from_set(params[:set], params[:white_cost], params[:blue_cost], params[:black_cost], params[:red_cost], params[:green_cost])

		flash.now[:notice] = "Your search returned #{@filtered.length} results!"

		@filtered = @filtered.paginate(:page => params[:page],:per_page => 10)
	end

end