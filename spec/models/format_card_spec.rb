# == Schema Information
#
# Table name: format_cards
#
#  id         :bigint           not null, primary key
#  format_id  :bigint
#  card_id    :bigint
#  forbidden  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe FormatCard, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
