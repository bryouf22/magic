# == Schema Information
#
# Table name: format_cards
#
#  id         :bigint(8)        not null, primary key
#  format_id  :bigint(8)
#  card_id    :bigint(8)
#  forbidden  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe FormatCard, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
