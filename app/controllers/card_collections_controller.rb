class CardCollectionsController < ApplicationController

  before_action :authenticate_user!

  def index
    @cardCollection = current_user.card_collection
  end
end
