# == Schema Information
#
# Table name: decks
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  colors     :integer
#  format_ids :integer
#  user_id    :integer
#  status     :integer          default("personal"), not null
#

class Deck < ApplicationRecord

  # validate user_id presence true
  # uniqueness name scope user id
  validates :name, presence: { message: 'Vous devez renseigner un nom.' }
  validates :user_id, presence: true
  validates :name, uniqueness: { scope: :user_id, message: "Vous possèdez déjà un deck avec ce nom !" }

  belongs_to :user
  has_one :main_deck
  has_one :sideboard

  enum status: { personal: 1, published: 2 }

  after_create :add_composition

  def cards
    Card.where(id: main_deck.card_ids + sideboard.card_ids)
  end

  private

  def add_composition
    MainDeck.create(deck_id: id)
    Sideboard.create(deck_id: id)
  end
end
