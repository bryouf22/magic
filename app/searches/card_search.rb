require "searchlight/adapters/action_view"

class CardSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def initialize(raw_options = {}) # TODO REFACTOR THIS
    super
    @user_cards = User.find(raw_options.delete('current_user_id')).card_collection.cards if raw_options['current_user_id']
  end

  def base_query
    @user_cards || Card.all
  end

  def search_color_restrict
    if color_ids.nil? && color_restrict == '1'
      query.colorless
    else
      query
    end
  end

  def search_exclude_color_ids
    records = query
    exclude_color_ids.each do |id|
      records = records.where.not(':color_id = ANY(color_ids)', color_id: id.to_i)
    end
    records
  end

  def search_term
    t = I18n.transliterate(term).downcase.parameterize
    query.where('cards.name_clean ILIKE ? OR cards.name_fr_clean ILIKE ?', "%#{t.strip}%", "%#{t.strip}%")
  end

  def search_extension_set_ids
    query.where('extension_set_id in (?)', extension_set_ids)
  end

  def search_color_ids
    if color_restrict == '1'
      query.where('color_ids = ARRAY[?]', color_ids.collect(&:to_i))
    else
      # https://www.postgresql.org/docs/current/functions-array.html
      query.where('color_ids && ARRAY[?]', color_ids.collect(&:to_i))
    end
  end

  def search_rarity_ids
    query.where(rarity: rarity_ids)
  end
end
