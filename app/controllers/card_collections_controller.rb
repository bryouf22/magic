class CardCollectionsController < ApplicationController
  before_action :authenticate_user!

  skip_before_action :verify_authenticity_token, only: :update_occurrence

  add_breadcrumb 'home', :root_path
  add_breadcrumb 'My collection', :card_collection_path

  def show
    @card_collection = current_user.card_collection
    if params['card_search'].present?
      @search = CardSearch.new(search_params.merge(current_user_id: current_user.id))
      list_by_colors(@search.results)
    else
      @search = CardSearch.new
      list_by_colors(Card.none)
    end
    set_meta_tags title: 'My collection'
    render :visual if view == 'visual'
  end

  def update_occurrence
    card_list = current_user.card_collection.card_lists.where(card_id: params[:card_id]).first
    card_list.update(number: params[:occurrence])
    respond_to do |format|
      format.json { render status: '200', body: nil }
    end
  end

  private

  def view
    return 'visual' if params['view'].present?
  end

  def search_params
    params.require('card_search').permit(:color_restrict, extension_set_ids: [], color_ids: [], rarity_ids: [], exclude_color_ids: [])
  end
end
