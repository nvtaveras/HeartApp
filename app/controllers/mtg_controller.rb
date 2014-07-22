require 'magic_api'

class MtgController < ApplicationController

	$mtg_api = MTGApi.new
	def searchmtg
	
	end

	def cardinfomtg

	end

	def resultsmtg
		
		@filtered = []
		
		@filtered = $mtg_api.can_buy_from_set(params[:set], params[:white_cost].to_i, params[:blue_cost].to_i, params[:black_cost].to_i, params[:red_cost].to_i, params[:green_cost].to_i)

		flash.now[:notice] = "Your search returned #{@filtered.length} results!"

		@filtered = @filtered.paginate(:page => params[:page],:per_page => 10)
	end

end