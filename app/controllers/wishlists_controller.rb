class WishlistsController < ApplicationController

  before_action :authenticate_user!

  def index
    @wishlists = current_user.wishlists
  end

  def new
    @wishlist = Wishlist.new(user_id: current_user.id)
  end

  def create
    @wishlist = Wishlist.create(wishlist_params.merge('user_id' => current_user.id))
    if @wishlist.valid?
      redirect_to wishlist_path(id: @wishlist)
    else
      render :new
    end
  end

  def update
    wishlist = current_user.wishlists.where(id: params['id']).first
    params['card_lists']&.each do |card_id|
      Wishlist::AddCards.call(wishlist_id: wishlist.id, card_id: card_id)
    end
    wishlist.update(wishlist_params)
    respond_to do |format|
      format.html { redirect_to edit_wishlist_path(id: wishlist.id) }
      format.js
    end
  end

  def edit
    @wishlist = current_user.wishlists.where(id: params['id']).first
  end

  def destroy
    if (wishlist = current_user.wishlists.where(id: params['id']).first)
      wishlist.destroy
      redirect_to wishlists_path
    end
  end

  def show
    @wishlist = Wishlist.find(params['id'])
    return redirect_to wishlists_path if current_user.id != @wishlist.user_id

    list_by_colors(@wishlist.cards)
    render :visual if view == 'visual'
  end

  private

  def wishlist_params
    params.require('wishlist').permit(:name, wishlist_card_ids: [])
  end
end
