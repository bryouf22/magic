# == Schema Information
#
# Table name: card_datas_legalities
#
#  id           :bigint           not null, primary key
#  card_data_id :integer
#  format       :string
#  legality     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe CardDatas::Legality, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
