# == Schema Information
#
# Table name: format_cards
#
#  id         :bigint           not null, primary key
#  format_id  :bigint
#  card_id    :bigint
#  forbidden  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FormatCard < ApplicationRecord
  belongs_to :format
  belongs_to :card

  # retrouver si une carte est interdite ou limitee a une occurence
  # pour depend du format (ex : en legacy ainsi qu'en modern, le format possede des cartes interdites, aucune carte n'est limitee a 1 exemplaire)
end
