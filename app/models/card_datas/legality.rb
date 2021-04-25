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

class CardDatas::Legality < ApplicationRecord

  belongs_to :card_data

end
