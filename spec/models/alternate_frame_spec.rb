# == Schema Information
#
# Table name: alternate_frames
#
#  id         :bigint           not null, primary key
#  card_id    :integer          not null
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe AlternateFrame, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
