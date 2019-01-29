class Format::Validator
  include Interactor

  def call
    deck = context.deck
    format = context.format

    (deck.nil? ? Deck.all : Deck.where(id: deck.id)).find_each do |_deck|
      puts "#{_deck.name}"
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

  def validate_format(format, deck)
    unless deck.card_in_main_deck
      puts "#{format.name} - #{deck.name} : deck sans carte"
      return false
    end
    if(deck.card_in_main_deck < format.card_limit)
      puts "#{format.name} - #{deck.name} : limite de carte"
      return false
    end
    deck.card_decks.find_each do |card_deck|
      card_number = card_deck.occurences_in_main_deck + card_deck.occurences_in_sideboard
      if(card_number > format.card_occurence_limit)
        puts "#{format.name} - #{deck.name} : nombre d'occurence #{card_deck.card.name}"
        return false
      end
    end
    format.cards.find_each do |card|
      if(deck.cards.where(id: card.card_ids).any?)
        puts "#{format.name} - #{deck.name} : carte interdide"
        return false
      end
    end
    format.extension_sets.find_each do |extension_set|
      if(deck.cards.where(extension_set_id: extension_set.id).any?)
        puts "#{format.name} - #{deck.name} : extension interdite"
        return false
      end
    end
    true
  end
end
