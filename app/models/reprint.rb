# == Schema Information
#
# Table name: reprints
#
#  id              :bigint           not null, primary key
#  card_id         :bigint
#  reprint_card_id :bigint
#

class Reprint < ApplicationRecord

  belongs_to :card
  belongs_to :reprint_card, class_name: 'Card'
end
