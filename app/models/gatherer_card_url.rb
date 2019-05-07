# == Schema Information
#
# Table name: gatherer_card_urls
#
#  id               :bigint(8)        not null, primary key
#  url              :string
#  extension_set_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class GathererCardUrl < ApplicationRecord

  belongs_to :extension_set

  validates :url, uniqueness: true
end
