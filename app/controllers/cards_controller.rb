class CardsController < ApplicationController

  before_action :authenticate_user!, only: :add_to

  def show
    @card = Card.find(params[:id]).decorate
  end

  def search
    @term     = search_params[:term]
    @search   = CardSearch.new(search_params)
    @results  = @search.results
    if request.format.to_sym == :json
      render json: {}
    end
  end

  def add_to
    case action_params
    when 'collection'
      CardCollection::AddCards.call(card_collection_id: current_user.card_collection.id, card_ids: card_ids)
      redirect_to card_collection_path
    when 'wishlist'
      create_default_wishlist if current_user.wishlists.none?
      Wishlist::AddCards.call(wishlist_id: current_user.wishlists.first.id, card_ids: card_ids)
      redirect_to wishlist_path(name: current_user.wishlists.first.id)
    end

  end

  private

  def create_default_wishlist
    Wishlist.create(name: 'Ma liste de souhait', user_id: current_user.id)
  end

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
