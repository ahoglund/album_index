class SearchController < ApplicationController

	def new
		build_search
	end

  def results
  	build_search 
  	render 'new' unless @search.save
  end

	private

	def build_search
    @search = Search.new(search_params)
	end

	def search_params
    search_params = params[:search]
    search_params ? search_params.permit(:q) : {}
	end
end
