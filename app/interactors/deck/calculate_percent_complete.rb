class Deck::CalculatePercentComplete
  include Interactor

  def call
    deck = Deck.find(context.deck_id)

    context.complete_percent = 100 - (deck.missing_cards.sum { |_k, v| v }.to_f / deck.card_number * 100).round.to_i
  end
end
