# == Schema Information
#
# Table name: alternatives
#
#  id                  :bigint(8)        not null, primary key
#  card_id             :integer
#  alternative_card_id :integer
#  alternative_type    :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Alternative < ApplicationRecord

  belongs_to :card
  belongs_to :alternative_card, class_name: 'Card'

  enum alternative_type: {
    recto_verso: 1,
    double_card: 2,
    flip_card:   3
  }
end
