class WishlistsController < ApplicationController

  before_action :authenticate_user!

  add_breadcrumb "home", :root_path
  add_breadcrumb "Listes de souhaits", :wishlists_path

  def index
    @wishlists = current_user.wishlists
  end

  def new
    @wishlist = Wishlist.new(user_id: current_user.id)
    add_breadcrumb "Nouvelle liste"
  end

  def create
    @wishlist = Wishlist.create(wishlist_params.merge('user_id' => current_user.id))
    if @wishlist.valid?
      redirect_to wishlist_path(slug: @wishlist.slug)
    else
      render :new
    end
  end

  def update
    wishlist = current_user.wishlists.where(slug: params['slug']).first
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
    @wishlist = current_user.wishlists.where(slug: params['slug']).first
    add_breadcrumb @wishlist.name, wishlist_path(slug: @wishlist.slug)
    add_breadcrumb "Édition"
  end

  def destroy
    if (wishlist = current_user.wishlists.where(slug: params['slug']).first)
      wishlist.destroy
      redirect_to wishlists_path
    end
  end

  def show
    @wishlist = current_user.wishlists.where(slug: params['slug']).first

    list_by_colors(@wishlist.cards)
    add_breadcrumb @wishlist.name, wishlist_path(slug: @wishlist.slug)
    if view == 'visual'
      render :visual
    end
  end

  private

  def wishlist_params
    params.require('wishlist').permit(:name, wishlist_card_ids: [])
  end
end
