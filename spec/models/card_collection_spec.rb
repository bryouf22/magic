# == Schema Information
#
# Table name: card_collections
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

require 'rails_helper'

RSpec.describe CardCollection, :type => :model do
end
