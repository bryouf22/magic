# == Schema Information
#
# Table name: reprints
#
#  id              :bigint(8)        not null, primary key
#  card_id         :bigint(8)
#  reprint_card_id :bigint(8)
#

class Reprint < ApplicationRecord

  belongs_to :card
  belongs_to :reprint_card, class_name: 'Card'
end
