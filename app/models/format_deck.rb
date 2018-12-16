# == Schema Information
#
# Table name: format_decks
#
#  id         :bigint(8)        not null, primary key
#  format_id  :bigint(8)
#  deck_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FormatDeck < ApplicationRecord

  belongs_to :format
  belongs_to :deck

end
