# == Schema Information
#
# Table name: decks
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  name              :string
#  colors            :integer          is an Array
#  format_ids        :integer          is an Array
#  user_id           :integer
#  status            :integer          default("personal"), not null
#  slug              :string
#  color_ids         :integer          is an Array
#  card_number       :integer
#  card_in_main_deck :integer
#  is_public         :boolean          default(FALSE)
#  description       :text
#  category_id       :integer
#  format            :integer          default(0), not null
#  complete_percent  :integer          default(0)
#

class Deck < ApplicationRecord
  include Bitfields

  validates :name,    presence: { message: 'Vous devez renseigner un nom.' }
  validates :name,    uniqueness: { scope: :user_id, message: 'Vous possèdez déjà un deck avec ce nom !' }
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :category, optional: true

  has_many :card_decks, dependent: :destroy
  has_many :cards, through: :card_decks

  enum status: { personal: 1, published: 2 }

  bitfield :format, 1 => :modern, 2 => :legacy, 4 => :standard, 8 => :commander, 16 => :pioneer
  bitfield :color, 1 => :black, 2 => :red, 4 => :blue, 8 => :green, 16 => :white

  scope :publics, -> { where(is_public: true) }

  before_save :update_slug, :set_colors, :set_card_numbers, :set_card_in_main_deck, :update_complete_percent # , :validate_formats

  def colors
    colors = []
    (color_ids || []).each do |id|
      colors << Color::COLORS_MAPPING.invert[id].to_s
    end
    colors
  end

  def generate_draft
    @draft = Draft::DraftFromCubeGenerator.call(deck_id: params['id']).tirages
  end

  def validate_formats
    Format::Validator.call(deck: self)
  end

  def formats
    bitfield_values(:format).collect { |n, v| n if v }.compact.join(', ').humanize
  end

  def missing_cards
    CardCollection::RetrieveMissingCardFromDeck.call(user_id: user.id, deck_id: id).result
  end

  private

  def set_card_numbers
    self['card_number'] = card_decks.sum { |card_deck| card_deck.occurences_in_main_deck + card_deck.occurences_in_sideboard }
  end

  def set_card_in_main_deck
    self['card_in_main_deck'] = card_decks.sum { |card_deck| card_deck.occurences_in_main_deck }
  end

  def set_colors
    c_ids = []
    cards.collect(&:colors).flatten.uniq.each do |color_name|
      c_ids << Color.__send__(color_name)
    end
    self['color_ids'] = c_ids
  end

  def update_complete_percent
    self['complete_percent'] = Deck::CalculatePercentComplete.call(deck_id: id).complete_percent unless new_records?
  end

  def update_slug
    self[:slug] = name.parameterize
  end
end
