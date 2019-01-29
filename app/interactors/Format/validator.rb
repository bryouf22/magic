class Format::Validator
  include Interactor

  def call
    deck = context.deck

    Format.all.each do |format|
      validaty  = validate_format(format, deck)
      if validaty
        FormatDeck.create(format_id: format.id, deck_id: deck.id) if deck.format_decks.where(format_id: format.id).none?
      else
        deck.format_decks.where(format_id: format.id).destroy_all
      end
    end
  end

  def validate_format(format, deck)
    if(deck.card_in_main_deck < format.card_limit)
      return false
    end
    deck.card_decks.each do |card_deck|
      card_number = card_deck.occurences_in_main_deck + card_deck.occurences_in_sideboard
      if(card_number > format.card_occurence_limit)
        return false
      end
    end
    format.cards.each do |card|
      if(deck.cards.where(id: card.card_ids).any?)
        return false
      end
    end
    true
  end
end
