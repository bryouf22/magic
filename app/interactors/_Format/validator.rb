class Format::Validator
  include Interactor

  # Format::Validator.call(deck: Deck.find(X), format: Format.where(name: 'Modern').first)
  def call
    deck = context.deck
    format = context.format

    (deck.nil? ? Deck.all : Deck.where(id: deck.id)).find_each do |_deck|
      (format.nil? ? Format.all : Format.where(id: format.id)).find_each do |_format|
        validaty  = validate_format(_format, _deck)
        if validaty
          FormatDeck.create(format_id: _format.id, deck_id: _deck.id) if _deck.format_decks.where(format_id: _format.id).none?
        else
          _deck.format_decks.where(format_id: _format.id).destroy_all
        end
      end
    end
  end

  private

  def validate_format(format, deck)
    unless deck.card_in_main_deck
      return false
    end
    if(deck.card_in_main_deck < format.card_limit)
      return false
    end
    deck.card_decks.find_each do |card_deck|
      next if card_deck.card.basic_land?
      card_number = card_deck.occurences_in_main_deck + card_deck.occurences_in_sideboard
      if(card_number > format.card_occurence_limit)
        return false
      end
    end
    format.cards.find_each do |card|
      if(deck.cards.where(id: card.card_ids).any?)
        return false
      end
    end
    format.extension_sets.find_each do |extension_set|
      if(deck.cards.where(extension_set_id: extension_set.id).any?)
        deck.cards.where(extension_set_id: extension_set.id).each do |card|

          forbiden_card = true
          (card.reprints.collect { |reprint| reprint.reprint_card.extension_set_id } + [card.extension_set_id]).each do |reprint_set_id|
            unless format.extension_sets.ids.include?(reprint_set_id)
              forbiden_card = false
            end
          end
          return false if forbiden_card
        end
      end
    end
    true
  end
end
