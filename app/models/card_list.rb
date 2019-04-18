# == Schema Information
#
# Table name: card_lists
#
#  id                 :bigint(8)        not null, primary key
#  card_id            :bigint(8)
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
