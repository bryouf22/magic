# == Schema Information
#
# Table name: formats
#
#  id                   :bigint           not null, primary key
#  name                 :string
#  card_limit           :integer
#  card_occurence_limit :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Format < ApplicationRecord

  has_many :format_cards, dependent: :destroy
  has_many :cards, through: :format_cards

  has_many :format_extensions, dependent: :destroy
  has_many :extension_sets, through: :format_extensions

  has_many :format_decks, dependent: :destroy
  has_many :decks, through: :format_decks
end
