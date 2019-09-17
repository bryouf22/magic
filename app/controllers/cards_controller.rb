require 'pagy'

class CardsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, only: :add_to

  def show
    @card = Card.find(params[:id]).decorate
  end

  def search
    @term     = search_params[:term]
    @search   = CardSearch.new(search_params)
    @pagy, @results  = pagy(@search.results.order('name ASC'), items: 20)
    respond_to do |format|
      format.json do
        json_result = []
        @results.each do |card|
          color = card.colors.join(', ')
          json_result << { id: card.id, text: "#{card.name} (#{card.extension_set.name}) #{color}" }
        end
        render json: json_result.to_json
      end
      format.html
    end
  end

  def adv_search
    if params['card_search'].present?
      @search = CardSearch.new(adv_search_params)
      list_by_colors(@search.results)
    else
      @search = CardSearch.new
      list_by_colors(Card.none)
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
      redirect_to wishlist_path(id: current_user.wishlists.first.id)
    end
  end

  def reprints_from_card
    @card = Card.find(params['id'])
    respond_to do |format|
      format.json do
        render json: @card.reprint_cards.decorate.collect { |reprint| { reprint.id => reprint.visual } }.push({ @card.id => @card.image_url }).to_json
      end
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

  def adv_search_params
     params.require('card_search').permit(:color_restrict, extension_set_ids: [], color_ids: [], rarity_ids: [], exclude_color_ids: [])
  end
end
