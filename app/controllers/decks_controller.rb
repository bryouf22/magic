require 'pagy'

class DecksController < ApplicationController
  include Pagy::Backend

  add_breadcrumb "home", :root_path

  before_action :authenticate_user!, except: %i[public_decks public_deck_show copy_public_deck]

  def calculate_complete_percent
    current_user.decks.where(id: params['id']).first.save
    redirect_to user_decks_path
  end

  def user_decks
    user_decks_search_params = search_params
    user_decks_search_params['card_ids'].reject!(&:blank?) if user_decks_search_params['card_ids'].present?
    @search = DeckSearch.new(user_decks_search_params.merge(current_user_id: current_user.id))
    @pagy, @decks = pagy(@search.results.order('complete_percent ASC, name ASC'), items: 100)
    add_breadcrumb "My decks", :user_decks_path
    set_meta_tags title: 'My decks'
  end

  def new
    @deck = current_user.decks.new
    add_breadcrumb "new deck"
    set_meta_tags title: 'New deck'
  end

  def create
    @deck = current_user.decks.create(update_params)
    if @deck.valid?
      redirect_to edit_deck_path(slug: @deck.slug)
    else
      render :new
    end
  end

  def export
    add_breadcrumb "My decks", :user_decks_path
    @deck = current_user.decks.where(slug: params[:slug]).first
    add_breadcrumb @deck.name, my_deck_path(slug: @deck.slug)
    add_breadcrumb "Export"
    set_meta_tags title: "Export #{@deck.name}"
  end

  def change_visual
    @initial_card = Card.find(params['change_visual']['initial_card_id'])
    @reprint_card = Card.find(params['change_visual']['reprint_card_id'])
    deck = current_user.decks.where(id: params['change_visual']['deck_id']).first
    deck.card_decks.where(card_id: @initial_card.id).first.update(card_id: @reprint_card.id)

    respond_to do |format|
      format.js
    end
  end

  def add_cards
    @deck = current_user.decks.where(slug: params['slug']).first
    params['deck_card_ids']&.each do |card_id|
      Deck::AddCard.call(deck_id: @deck.id, card_id: card_id)
    end
    build_deck_for_show
    respond_to do |format|
      format.html { redirect_to edit_deck_path(slug: @deck.slug) }
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
    deck = Deck.find(deck_id)
    Format::Validator.call(deck: deck)
    redirect_to my_deck_path(id: deck.id)
  end

  def detail
    add_breadcrumb "My decks", :user_decks_path
    @deck = Deck.where(slug: params[:slug]).first
    build_deck_for_show
    add_breadcrumb @deck.name, my_deck_path(slug: @deck.slug)
    add_breadcrumb "Advanced view"
    set_meta_tags title: @deck.name
  end

  def show
    add_breadcrumb "My decks", :user_decks_path
    @deck = current_user.decks.where(slug: params[:slug]).first
    build_deck_for_show
    add_breadcrumb @deck.name, my_deck_path(slug: @deck.slug)
    set_meta_tags title: @deck.name
  end

  def show_by_color
    add_breadcrumb "My decks", :user_decks_path
    @deck = Deck.where(slug: params[:slug]).first
    build_deck_for_show
    add_breadcrumb @deck.name
    set_meta_tags title: @deck.name
  end

  def edit
    add_breadcrumb "My decks", :user_decks_path
    @deck = current_user.decks.where(slug: params[:slug]).first
    build_deck_for_show
    add_breadcrumb @deck.name, my_deck_path(slug: @deck.slug)
    add_breadcrumb "Edition"
    set_meta_tags title: "Edit #{@deck.name}"
  end

  def update
    @deck = current_user.decks.where(slug: params[:slug]).first
    if @deck.update_attributes(update_params)
      Format::Validator.call(deck: @deck)
      redirect_to my_deck_path(slug: @deck.slug)
    else
      build_deck_for_show
      render :edit
    end
  end

  def destroy
    current_user.decks.where(slug: params[:slug]).first.destroy
    redirect_to user_decks_path
  end

  def manage_card
    @deck_id = params['deck']['deck_id']
    @card_id = params['deck']['card_id']
    deck     = Deck.find(@deck_id)

    return render js: nil if current_user&.id != deck.user_id

    @operator_in = (params['deck']['operator'].include?('maindeck') ? :main_deck : :sideboard)

    if params['deck']['operator'].include?('plus')
      @operator = 'add'
      Deck::AddCard.call(deck_id: @deck_id, card_id: @card_id, in: @operator_in)
    elsif params['deck']['operator'].include?('minus')
      @operator = 'remove'
      Deck::RemoveCard.call(deck_id: @deck_id, card_id: @card_id, from: @operator_in)
    elsif params['deck']['operator'].include?('move')
      Deck::MoveCard.call(deck_id: @deck_id, card_id: @card_id, move_in: @operator_in)
      @operator = 'move'
    end

    Format::Validator.call(deck: deck)

    respond_to do |format|
      format.html { redirect_to edit_deck_path(slug: deck.slug) }
      format.js
    end
  end

  def import
    add_breadcrumb "new deck", new_deck_path
    add_breadcrumb "Import"
    set_meta_tags title: "Import a deck"
  end

  def import_create
    deck = Deck::CreateFromList.call(list: params[:import][:list], user_id: current_user.id).deck
    Format::Validator.call(deck: deck)
    redirect_to my_deck_path(slug: deck.slug)
  end

  def public_decks
    @decks = Deck.publics
    set_meta_tags title: 'Decks'
  end

  def public_deck_show
    @deck = Deck.find(params['id'])
    set_meta_tags title: @deck.name
    build_deck_for_show
    render :show
  end

  def copy_public_deck
    deck = Deck.find(params['id'])
    new_deck_id = Deck::CopyDeck.call(deck_id: deck.id, user_id: current_user.id).deck_id
    redirect_to my_deck_path(id: Deck.id(new_deck_id).slug)
  end

  def generate_draft
    @draft = Draft::DraftFromCubeGenerator.call(deck_id: params['id']).tirages
  end

  def add_wishlist
    add_breadcrumb "My decks", :user_decks_path
    if (@deck = current_user.decks.where(id: params['id']).first)
      @cards = cards_sorted(@deck)
      add_breadcrumb @deck.name, my_deck_path(slug: @deck.slug)
      add_breadcrumb "Add cards to wishlist"
    else
      @cards = card_list
      render :decks_cards
    end
  end

  def add_collection
    add_breadcrumb "My decks", :user_decks_path
    if (@deck = current_user.decks.where(id: params['id']).first)
      @cards = cards_sorted(@deck)
      add_breadcrumb @deck.name, my_deck_path(slug: @deck.slug)
      add_breadcrumb "Add cards to collection"
    else
      @cards = card_list
      render :decks_cards
    end
  end

  def add_cards_to_collection
    if params['commit'] == 'Remove'
      CardCollection::RemoveCards.call(add_to_collection_params.merge(card_collection_id: current_user.card_collection.id))
    else
      CardCollection::AddCards.call(add_to_collection_params.merge(card_collection_id: current_user.card_collection.id))
    end
    respond_to do |format|
      format.js do
        @card = Card.find(add_to_collection_params['card_id'])
        @deck = Deck.find(params['id'])
        @cards = cards_sorted(@deck)
      end
      format.html { redirect_to add_to_collection_deck_path(params['id']) }
    end
  end

  def card_list
    results = {}
    current_user.decks.each do |deck|
      next if deck.name.match(/cube/i).present?
      deck.card_decks.each do |card|
        next if card.card.basic_land?
        count = card.occurences_in_main_deck.to_i + card.occurences_in_sideboard.to_i
        card_name = card.card.name
        if results[card_name].present?
          unless results[card_name][:decks].include?(deck.name)
            results[card_name][:decks] << deck.name
          end
          if results[card_name][:count] < count
            results[card_name][:count] = count
          end
        else
          results[card_name] = { count: count, id: card.card.id, decks: [deck.name] }
        end
      end
    end
    results
  end

  def missing_card_from_decks
    add_breadcrumb "My decks", :user_decks_path
    @missings = {}
    @decks    = current_user.decks.where(id: params['missing_card_from_dekcs']['deck_ids'])

    @decks.collect(&:missing_cards).each do |m|
      next unless m.present?
      m.each do |name, count|
        if @missings[name].nil?
          @missings[name] = count
        elsif count > @missings[name]
          @missings[name] = count
        end
      end
    end
  end

  private

  def cards_sorted(deck)
    result = {}
    deck.card_decks.each do |card|
      # next if card.card.basic_land?
      count = card.occurences_in_main_deck.to_i + card.occurences_in_sideboard.to_i
      card_id = card.card.id
      if result[card_id].present?
        if result[card_id] < count
          result[card_id] = count
        end
      else
        result[card_id] = count
      end
    end
    result
  end

  def build_deck_for_show
    @main_cards = Card.where(id: @deck.card_decks.main_deck.collect(&:card_id))
    @sideboards = Card.where(id: @deck.card_decks.sideboard.collect(&:card_id))
  end

  def add_to_collection_params
    params.require(:add_collection).permit(:card_id, :count)
  end

  def add_card_params
    params.require(:add_to_deck).permit(:card_id, :deck_id)
  end

  def update_params
    params.require(:deck).permit(:name, :is_public, :description, :category_id)
  end

  def search_params
    if params['deck_search'].present?
      params.require('deck_search').permit(card_ids: [])
    else
      {}
    end
  end
end
