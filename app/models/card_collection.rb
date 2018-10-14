# == Schema Information
#
# Table name: card_collections
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  card_ids   :integer          is an Array
#  user_id    :integer
#

class CardCollection < ApplicationRecord
  include CardList

  belongs_to :user

  # TODO : validate user id presence true

end
