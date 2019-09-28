class Deck::Create
  include Interactor

  def call
    user_id = context.user_id
    name    = context.name || 'Nouveau deck'
    @user   = User.find(user_id)

    deck = if @user.decks.where(name: name).any?
             Deck.create(user_id: user_id, name: generate_name(name))
           else
             Deck.create(user_id: user_id, name: name)
           end
    context.deck_id = deck.id
  end

  private

  def generate_name(name)
    index = 0
    loop do
      index += 1
      break if @user.decks.where(name: "#{name} #{index}").none?
    end
    "#{name} #{index}"
  end
end
