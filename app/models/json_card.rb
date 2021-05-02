# == Schema Information
#
# Table name: json_cards
#
#  id          :bigint           not null, primary key
#  json_set_id :integer
#  name        :string
#  json_data   :json
#  uuid        :string
#  number      :string
#  sort_number :integer
#  image       :string
#

class JsonCard < ApplicationRecord

  belongs_to :json_set

  mount_uploader :image, CardImageUploader

  def face_name
    json_data['faceName'].presence || name
  end
end
