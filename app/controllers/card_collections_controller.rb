class CardCollectionsController < ApplicationController

  before_action :authenticate_user!

  skip_before_action :verify_authenticity_token, only: :update_occurrence

  def show
    @card_collection = current_user.card_collection
    if params['card_search'].present?
      @search = CardSearch.new(search_params.merge(current_user_id: current_user.id)) # CardSearch.new({ extension_set_ids, [12, 24], current_user_id: 15 }
      list_by_colors(@search.results)
    else
      @search = CardSearch.new
      list_by_colors(Card.none)
    end

    render :visual if view == 'visual'
  end

  def update_occurrence
    card_list = current_user.card_collection.card_lists.where(card_id: params[:card_id]).first
    if card_list.update(number: params[:occurrence])
      respond_to do |format|
        format.json { render status: '200', body: nil }
      end
    else
      #ERROR
    end
  end

  private

  def search_params
     params.require('card_search').permit(:color_restrict, extension_set_ids: [], color_ids: [], rarity_ids: [], exclude_color_ids: [])
  end
end
