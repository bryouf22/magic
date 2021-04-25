# == Schema Information
#
# Table name: card_datas_foreign_names
#
#  id                :bigint           not null, primary key
#  card_data_id      :integer
#  name              :string
#  text              :string
#  foreign_name_type :string
#  flavor            :string
#  image_url         :string
#  language          :string
#  multiverseid      :integer
#  face_name         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class CardDatas::ForeignName < ApplicationRecord

  belongs_to :card_data

end
