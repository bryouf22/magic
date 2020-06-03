require "searchlight/adapters/action_view"

class DeckSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def initialize(raw_options = {}) # TODO REFACTOR THIS
    super
    @decks = User.find(raw_options.delete(:current_user_id)).decks if raw_options[:current_user_id]
  end

  def base_query
    @decks || Deck.all
  end

  def search_card_ids
    @decks.joins(:card_decks).where('card_decks.card_id in (?)', Card.where(id: card_ids).collect(&:card_ids).flatten)
  end
end
