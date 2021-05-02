# == Schema Information
#
# Table name: json_tokens
#
#  id          :bigint           not null, primary key
#  uuid        :string
#  name        :string
#  json_set_id :integer
#  json_data   :json
#  number      :string
#  sort_number :integer
#  image       :string
#

class JsonToken < ApplicationRecord

  belongs_to :json_set

  mount_uploader :image, CardImageUploader

  json_data['faceName'].presence || name
end
