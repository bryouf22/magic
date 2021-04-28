# == Schema Information
#
# Table name: json_sets
#
#  id             :bigint           not null, primary key
#  code           :string
#  name           :string
#  json_data      :json
#  set_type       :string
#  release_date   :string
#  total_set_size :integer
#

class JsonSet < ApplicationRecord
  has_many :json_cards, class_name: 'JsonCard', foreign_key: :json_set_id
  has_many :json_tokens, class_name: 'JsonToken', foreign_key: :json_set_id

  validates :code, :name, presence: true
  validates :code, :name, uniqueness: true
end
