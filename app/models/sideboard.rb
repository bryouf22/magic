# == Schema Information
#
# Table name: sideboards
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deck_id    :integer
#  card_ids   :integer          default([]), is an Array
#

class Sideboard < ApplicationRecord
  include CardList

  belongs_to :deck

end
