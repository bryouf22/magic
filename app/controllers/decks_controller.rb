class DecksController < ApplicationController

  before_action :authenticate_user!

  def index
    @decks = current_user.decks
  end

  def new
    @deck = current_user.decks.new
  end

  def create
    @deck = current_user.decks.create(update_params)
    if @deck.valid?
      redirect_to decks_path
    else
      render :new
    end
  end

  def add_card
    deck_id = if add_card_params[:deck_id].blank?
                Deck::Create.call(user_id: current_user.id).deck_id
              else
                add_card_params[:deck_id]
              end
    Deck::AddCard.call(deck_id: deck_id, card_id: add_card_params[:card_id])
    redirect_to deck_path(slug: Deck.find(deck_id).slug)
  end

  def show
    @deck = current_user.decks.where(slug: params[:slug]).first
  end

  def edit
    @deck = Deck.where(slug: params[:slug]).first
  end

  def update
    @deck = Deck.where(slug: params[:slug]).first

    if @deck.update_attributes(update_params)
      redirect_to deck_path(slug: @deck.slug)
    else
      render :edit
    end
  end

  private

  def add_card_params
    params.require(:add_to_deck).permit(:card_id, :deck_id)
  end

  def update_params
    params.require(:deck).permit(:name)
  end
end
