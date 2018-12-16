# == Schema Information
#
# Table name: format_cards
#
#  id         :bigint(8)        not null, primary key
#  format_id  :bigint(8)
#  card_id    :bigint(8)
#  forbidden  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FormatCard < ApplicationRecord

  belongs_to :format
  belongs_to :card

  # retrouver si une carte est interdite ou limitée à une occurence

end
