# == Schema Information
#
# Table name: card_collections
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  card_ids   :integer          is an Array
#  user_id    :integer
#

class CardCollection < ApplicationRecord

  belongs_to :user

  # TODO : validate user id presence true

  # TODO : faire un concern pour CordCollection, wishlist, maindeck et sidebard pour les methodes communes : concern CardList
  def add_card(id)
    update_columns(card_ids: (card_ids << id))
  end

  def add_cards(card_ids)
    update_columns(card_ids: (card_ids + card_ids))
  end

  def cards
    Card.where(id: card_ids) # FIXME : si un id est présent deux fois dans card_ids, cela ne sortira pas pour autant la carte 2 fois
  end
end
