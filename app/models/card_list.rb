# == Schema Information
#
# Table name: card_lists
#
#  id                 :bigint           not null, primary key
#  card_id            :bigint
#  card_listable_id   :integer
#  card_listable_type :string
#  number             :integer
#  foils_number       :integer
#

class CardList < ApplicationRecord

  belongs_to :card_listable, polymorphic: true
  belongs_to :card

  validates :card_id, uniqueness: { scope: :card_listable_id, message: "already in list (update number / foils_number" }
end
