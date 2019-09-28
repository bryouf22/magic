class Format::Validator
  include Interactor

  # Format::Validator.call(deck: Deck.find(X), format: Format.where(name: 'Modern').first)
  def call
    deck = context.deck
    format = context.format

    (deck.nil? ? Deck.all : Deck.where(id: deck.id)).find_each do |d|
      (format.nil? ? Format.all : Format.where(id: format.id)).find_each do |f|
        validaty = validate_format(f, d)
        if validaty
          FormatDeck.create(format_id: f.id, deck_id: d.id) if d.format_decks.where(format_id: f.id).none?
        else
          d.format_decks.where(format_id: f.id).destroy_all
        end
      end
    end
  end

  private

  def validate_format(format, deck)
    return false unless deck.card_in_main_deck
    return false if deck.card_in_main_deck < format.card_limit

    deck.card_decks.find_each do |card_deck|
      next if card_deck.card.basic_land?

      card_number = card_deck.occurences_in_main_deck + card_deck.occurences_in_sideboard
      return false if card_number > format.card_occurence_limit
    end
    format.cards.find_each do |card|
      return false if deck.cards.where(id: card.card_ids).any?
    end
    format.extension_sets.find_each do |extension_set|
      if deck.cards.where(extension_set_id: extension_set.id).any?
        deck.cards.where(extension_set_id: extension_set.id).each do |card|
          forbiden_card = true
          (card.reprints.collect { |reprint| reprint.reprint_card.extension_set_id } + [card.extension_set_id]).each do |reprint_set_id|
            forbiden_card = false unless format.extension_sets.ids.include?(reprint_set_id)
          end
          return false if forbiden_card
        end
      end
    end
    true
  end
end
