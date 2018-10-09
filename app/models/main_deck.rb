# == Schema Information
#
# Table name: main_decks
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  card_ids   :integer
#  deck_id    :integer
#

class MainDeck < ApplicationRecord

  belongs_to :deck

  def cards
    Card.where(id: card_ids)
  end

  def add_card(id)
    update_columns(card_ids: (card_ids << id))
  end

  def cards
    Card.where(id: card_ids)
  end
end
