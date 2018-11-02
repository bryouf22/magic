class CardCollectionsController < ApplicationController

  before_action :authenticate_user!

  def show
    @card_collection = current_user.card_collection
    list_by_colors(@card_collection.cards)
  end
end
