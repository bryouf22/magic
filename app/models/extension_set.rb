# == Schema Information
#
# Table name: extension_sets
#
#  id             :bigint           not null, primary key
#  name           :string
#  release_date   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  slug           :string
#  set_type       :integer
#  bloc_id        :integer
#  set_list_id    :integer
#  code           :string
#  card_count     :integer
#  new_card_count :integer
#  reprint_count  :integer
#  configured     :boolean          default(FALSE)
#

class ExtensionSet < ApplicationRecord
  has_many :cards
  has_many :gatherer_card_urls

  belongs_to :bloc, optional: true
  belongs_to :set_list, optional: true

  before_create :generate_slug

  enum set_type: {
    block_set: 1,
    basic_edition: 2,
    from_the_vault: 3,
    dual_deck: 4,
    reedition: 5,
    premium_deck: 6,
    humouristic: 7,
    starter: 8,
    other: 9,
    online: 10,
    masterpiece: 11,
    commander: 12,
    guild_kit: 13,
    global_series: 14,
    mythic_editions: 15,
    signature_spellbooks: 16
  }

  def cards_for_list
    # TODO
    # > recto_verso : ne pas afficher le verso, sur la page vue, afficher le verso au clic
    # > double_card : afficher dans une section "cartes doubles" dans la liste, sur la fiche afficher avec un rotate 90
    # > flip_card : ne pas afficher le double, sur la vue, permettre un rotate (idem magic ville)
    # > adventure : ne pas afficher l'aventure
  end

  def resort_card_number!
    i = 1
    cards.where(set_extra_card: [nil, false]).colorless_non_artefact.order(name: :asc).each do |card|
      card.update(number_in_set: i)
      i += 1
    end
    cards.where(set_extra_card: [nil, false]).only_white.order(name: :asc).each do |card|
      card.update(number_in_set: i)
      i += 1
    end
    cards.where(set_extra_card: [nil, false]).only_blue.order(name: :asc).each do |card|
      card.update(number_in_set: i)
      i += 1
    end
    cards.where(set_extra_card: [nil, false]).only_black.order(name: :asc).each do |card|
      card.update(number_in_set: i)
      i += 1
    end
    cards.where(set_extra_card: [nil, false]).only_red.order(name: :asc).each do |card|
      card.update(number_in_set: i)
      i += 1
    end
    cards.where(set_extra_card: [nil, false]).only_green.order(name: :asc).each do |card|
      card.update(number_in_set: i)
      i += 1
    end
    cards.where(set_extra_card: [nil, false]).gold_not_hybrids.not_double.order(name: :asc).each do |card|
      card.update(number_in_set: i)
      i += 1
    end
    cards.where(set_extra_card: [nil, false]).hybrids.not_double.order(name: :asc).each do |card|
      card.update(number_in_set: i)
      i += 1
    end
    cards.where(set_extra_card: [nil, false]).colorless_artefact.order(name: :asc).each do |card|
      card.update(number_in_set: i)
      i += 1
    end
    cards.where(set_extra_card: [nil, false]).lands.order(name: :asc).each do |card|
      next if card.basic_land?

      card.update(number_in_set: i)
      i += 1
    end
    cards.where(set_extra_card: [nil, false]).lands.order(name: :asc).each do |card|
      next unless card.basic_land?

      card.update(number_in_set: i)
      i += 1
    end
  end

  private

  def generate_slug
    self[:slug] = name.parameterize
  end
end
