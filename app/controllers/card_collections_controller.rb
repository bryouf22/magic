class CardCollectionsController < ApplicationController

  before_action :authenticate_user!

  def show
    @card_collection = current_user.card_collection
    @cards = @card_collection.cards
    list_by_colors
  end
end
