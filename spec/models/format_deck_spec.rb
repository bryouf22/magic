# == Schema Information
#
# Table name: format_decks
#
#  id         :bigint           not null, primary key
#  format_id  :bigint
#  deck_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe FormatDeck, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
