# == Schema Information
#
# Table name: card_collections
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  card_ids   :integer
#  user_id    :integer
#

class CardCollection < ApplicationRecord

  belongs_to :user

  # validate user id presence true
end
