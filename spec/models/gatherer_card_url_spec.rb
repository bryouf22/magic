# == Schema Information
#
# Table name: gatherer_card_urls
#
#  id               :bigint           not null, primary key
#  url              :string
#  extension_set_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe GathererCardUrl, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
