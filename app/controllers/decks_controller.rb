class DecksController < ApplicationController

  before_action :authenticate_user!, except: [:public_decks, :public_deck_show, :copy_public_deck]

  def user_decks
    @decks = current_user.decks
  end

  def new
    @deck = current_user.decks.new
  end

  def create
    @deck = current_user.decks.create(update_params)
    if @deck.valid?
      redirect_to edit_deck_path(slug: @deck.slug)
    else
      render :new
    end
  end

  def add_cards
    deck = current_user.decks.where(slug: params['slug']).first
    params['deck_card_ids']&.each do |card_id|
      Deck::AddCard.call(deck_id: deck.id, card_id: card_id)
    end
    respond_to do |format|
      format.html { redirect_to edit_deck_path(slug: deck.slug) }
      format.js
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

  def detail
    @deck = Deck.where(slug: params[:slug]).first
    build_deck_for_show
  end

  def show
    @deck       = Deck.where(slug: params[:slug]).first
    build_deck_for_show
  end

  def edit
    @deck = current_user.decks.where(slug: params[:slug]).first
    build_deck_for_show
  end

  def update
    @deck = Deck.where(slug: params[:slug]).first
    if @deck.update_attributes(update_params)
      redirect_to deck_path(slug: @deck.slug)
    else
      render :edit
    end
  end

  def destroy
    current_user.decks.where(slug: params[:slug]).first.destroy
    redirect_to user_decks_path
  end

  def manage_card
    # fix : check current deck / current user
    @deck_id = params["deck"]["deck_id"]
    @card_id = params["deck"]["card_id"]
    @operator_in = (params["deck"]['operator'].include?('maindeck') ? :main_deck : :sideboard)
    if params["deck"]['operator'].include?("plus")
      @operator = "add"
      Deck::AddCard.call(deck_id: @deck_id, card_id: @card_id, in: @operator_in)
    elsif params["deck"]['operator'].include?("minus")
      @operator = "remove"
      Deck::RemoveCard.call(deck_id: @deck_id, card_id: @card_id, in: @operator_in)
    elsif params["deck"]['operator'].include?('move')
      Deck::MoveCard.call(deck_id: @deck_id, card_id: @card_id, move_in: @operator_in)
      @operator = "move"
    end
    respond_to do |format|
      format.html { redirect_to edit_deck_path(slug: Deck.find(@deck_id).slug) }
      format.js
    end
  end

  def import
  end

  def import_create
    deck = Deck::CreateFromList.call(list: params[:import][:list], user_id: current_user.id).deck
    redirect_to deck_path(slug: deck.slug)
  end

  def public_decks
    @decks = Deck.is_public
  end

  def public_deck_show
    @deck = Deck.find(params['id'])
    build_deck_for_show
    render :show
  end

  def copy_public_deck
    deck = Deck.find(params['id'])
    new_deck_id = Deck::CopyDeck.call(deck_id: deck.id, user_id: current_user.id).deck_id
    redirect_to my_deck_path(slug: Deck.find(new_deck_id).slug)
  end

  private

  def build_deck_for_show
    @main_cards = Card.where(id: @deck.card_decks.main_deck.collect(&:card_id))
    @sideboards = Card.where(id: @deck.card_decks.sideboard.collect(&:card_id))
  end

  def add_card_params
    params.require(:add_to_deck).permit(:card_id, :deck_id)
  end

  def update_params
    params.require(:deck).permit(:name, :is_public)
  end
end
