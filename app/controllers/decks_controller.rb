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
    deck = current_user.decks.find(add_card_params[:deck_id])
    deck.main_deck.add_card(add_card_params[:card_id])
    redirect_to deck_path(deck)
  end

  def show
    @deck = current_user.decks.where(id: params[:id]).first
    @deck = Deck.published.find(params[:id]) unless @deck
  end

  def edit
    @deck = Deck.find(params[:id])
  end

  def update
    @deck = Deck.find(params[:id])

    if @deck.update_attributes(update_params)
      redirect_to deck_path(@deck)
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
