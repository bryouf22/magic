class Deck::CopyDeck
  include Interactor

  def call
    user          = User.find(context.user_id)
    deck_to_copy  = Deck.find(context.deck_id)
    deck_name     = user.decks.where(name: deck_to_copy.name).any? ? generate_name(deck_to_copy.name, user) : deck_to_copy.name
    new_deck      = Deck.create(name: deck_name, user_id: user.id)

    if (new_deck.valid?)
      deck_to_copy.card_decks.each do |card_deck|
        CardDeck.create(
          card_id: card_deck.card_id,
          deck_id: new_deck.id,
          occurences_in_main_deck: card_deck.occurences_in_main_deck,
          occurences_in_sideboard: card_deck.occurences_in_sideboard
        )
      end
    else
      context.error = "Une erreur est survenu ! C'est balo !"
      context.fail!
    end
    context.deck_id = new_deck.id
  end

  private

  def generate_name(name, user)
    index = 0
    loop do
      index += 1
      break if user.decks.where(name: "#{name} #{index}").none?
    end
    "#{name} #{index}"
  end
end
