module CardList
  extend ActiveSupport::Concern

  def add_card(id)
    update_columns(card_ids: (card_ids << id))
  end

  def add_cards(card_ids)
    update_columns(card_ids: (Array.wrap(self[:card_ids]) + card_ids))
  end

  def cards
    Card.where(id: card_ids) # FIXME : si un id est présent deux fois dans card_ids, cela ne sortira pas pour autant la carte 2 fois
  end
end
