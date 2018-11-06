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

require 'rails_helper'

RSpec.describe Alternative, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
