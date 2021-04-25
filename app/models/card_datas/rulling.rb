# == Schema Information
#
# Table name: card_datas_rullings
#
#  id           :bigint           not null, primary key
#  card_data_id :integer
#  date         :string
#  text         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CardDatas::Rulling < ApplicationRecord

  belongs_to :card_data

end
