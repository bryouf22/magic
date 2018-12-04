class CardsController < ApplicationController

  before_action :authenticate_user!, only: :add_to

  def show
    @card = Card.find(params[:id]).decorate
  end

  def search
    @term     = search_params[:term]
    @search   = CardSearch.new(search_params)
    @results  = @search.results
    if request.format.to_sym == json
      render json: {}
    end
  end

  def add_to
    case action_params
    when 'collection'
    when 'wishlist'
    when 'deck'
    end
    redirect_to root_path
  end

  private

  def search_params
    params.require('card_search').permit(:term)
  end

  def action_params
    params.require(:add).permit(:to)[:to]
  end

  def card_ids
    params.require(:card_ids)
  end
end
