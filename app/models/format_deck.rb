# == Schema Information
#
# Table name: format_decks
#
#  id         :bigint           not null, primary key
#  format_id  :bigint
#  deck_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FormatDeck < ApplicationRecord

  belongs_to :format
  belongs_to :deck
end
