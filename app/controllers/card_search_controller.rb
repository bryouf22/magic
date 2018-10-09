class CardSearchController < ApplicationController

  def new
    @term     = search_params[:term]
    @search   = CardSearch.new(search_params)
    @results  = @search.results
  end

  private

  def search_params
    params.require('card_search').permit(:term)
  end
end
