# == Schema Information
#
# Table name: decks
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string
#  colors      :integer          is an Array
#  format_ids  :integer          is an Array
#  user_id     :integer
#  status      :integer          default("personal"), not null
#  slug        :string
#  color_ids   :integer          is an Array
#  card_number :integer
#

class Deck < ApplicationRecord

  validates :name,    presence: { message: 'Vous devez renseigner un nom.' }
  validates :name,    uniqueness: { scope: :user_id, message: "Vous possèdez déjà un deck avec ce nom !" }
  validates :user_id, presence: true

  belongs_to :user

  has_many :card_decks, dependent: :destroy
  has_many :cards, through: :card_decks

  has_many :format_decks, dependent: :destroy
  has_many :formats, through: :format_decks

  enum status: { personal: 1, published: 2 }

  before_save :update_slug, :set_colors, :set_card_numbers, :validate_formats

  def colors
    colors = []
    (color_ids|| []).each do |id|
      colors << Color::COLORS_MAPPING.invert[id].to_s
    end
    colors
  end

  private

  def set_card_numbers
    self['card_number'] = card_decks.sum { |card_deck| card_deck.occurences_in_main_deck + card_deck.occurences_in_sideboard }
  end

  def set_colors
    c_ids = []
    cards.collect(&:colors).flatten.uniq.each do |color_name|
      c_ids << Color.__send__(color_name)
    end
    self['color_ids'] = c_ids
  end

  def update_slug
    self[:slug] = name.parameterize
  end

  def validate_formats
    Format::Validator.call(deck: self)
  end
end
