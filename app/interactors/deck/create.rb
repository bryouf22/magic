class Deck::Create
  include Interactor

  def call
    user_id = context.user_id
    deck = Deck.create(user_id: user_id, name: "Nouveau deck #{rand(1000)}") # FIXME
    context.deck_id = deck.id
  end
end
