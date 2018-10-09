class WishlistsController < ApplicationController

  before_action :authenticate_user!

  def index
    @wishlists = current_user.wishlists
  end
end
