# == Schema Information
#
# Table name: json_cards
#
#  id          :bigint           not null, primary key
#  json_set_id :integer
#  name        :string
#  json_data   :json
#  uuid        :string
#  number      :integer
#

class JsonCard < ApplicationRecord

  belongs_to :json_set

end
