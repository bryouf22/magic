# == Schema Information
#
# Table name: json_tokens
#
#  id          :bigint           not null, primary key
#  uuid        :string
#  name        :string
#  json_set_id :integer
#  json_data   :json
#

class JsonToken < ApplicationRecord

  belongs_to :json_set

end
