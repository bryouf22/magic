# == Schema Information
#
# Table name: set_data
#
#  id           :bigint           not null, primary key
#  code         :string
#  name         :string
#  set_type     :string
#  booster      :string           is an Array
#  release_date :string
#  block        :string
#  online_only  :boolean
#


class SetData < ApplicationRecord

  has_many :cards, class_name: 'CardData', foreign_key: :set_data_id
end
