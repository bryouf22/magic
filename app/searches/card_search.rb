require "searchlight/adapters/action_view"

class CardSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def initialize(raw_options = {}) #TODO REFACTOR THIS
    string_keys, non_string_keys = raw_options.keys.partition {|k| k.is_a?(String) }
    intersection = string_keys & non_string_keys.map(&:to_s)
    if intersection.any?
      fail ArgumentError, "more than one key converts to these string values: #{intersection}"
    end
    @user_cards = User.find(raw_options.delete('current_user_id')).card_collection.cards if raw_options['current_user_id']
    @raw_options = raw_options
  end

  def base_query
    @user_cards || Card.all
  end

  def search_term
    t = I18n.transliterate(term).downcase
    query.where("cards.name_clean ILIKE ? OR cards.name_fr_clean ILIKE ?", "%#{t}%", "%#{t}%")
  end

  def search_extension_set_ids
    0/0
  end

  def search_color_ids
    0/0
  end

  def search_rarity_ids
    0/0
  end
end
