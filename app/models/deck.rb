# == Schema Information
#
# Table name: decks
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  colors     :integer          is an Array
#  format_ids :integer          is an Array
#  user_id    :integer
#  status     :integer          default("personal"), not null
#  slug       :string
#

class Deck < ApplicationRecord

  validates :name,    presence: { message: 'Vous devez renseigner un nom.' }
  validates :name,    uniqueness: { scope: :user_id, message: "Vous possèdez déjà un deck avec ce nom !" }
  validates :user_id, presence: true

  belongs_to :user

  has_many :card_decks, dependent: :destroy
  has_many :cards, through: :card_decks

  enum status: { personal: 1, published: 2 }

  before_save :update_slug

  def cards
    Card.where(id: main_deck.card_ids + sideboard.card_ids)
  end

  private

  def update_slug
    self[:slug] = name.parameterize
  end
end
