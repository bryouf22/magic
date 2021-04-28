# == Schema Information
#
# Table name: set_datas
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

  self.table_name = "set_datas"

  has_many :card_datas
end
