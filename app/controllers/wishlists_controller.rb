class WishlistsController < ApplicationController

  before_action :authenticate_user!

  def index
    @wishlists = current_user.wishlists
  end

  def new
  end

  def show
    @wishlist = Wishlist.find(params['id'])
    return redirect_to wishlists_path if current_user.id != @wishlist.user_id
    list_by_colors(@wishlist.cards)
    render :visual if view == 'visual'
  end
end
