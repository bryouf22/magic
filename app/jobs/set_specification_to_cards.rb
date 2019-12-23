class SetSpecificationToCards < ApplicationJob
  queue_as :default

  def perform(cards = [])
    cards = cards.presence || Card
    cards.find_each do |card|
      if card.has_alternative?
        card.update(is_double_card: true)
      elsif card.is_alternative?
        card.update(is_double_part: true)
      end
      card.update(hybrid: true) if is_hybrid?(card.mana_cost)
    end

    # TODO card.alternative_type
  end

  def is_hybrid?(mana_cost = '')
    (mana_cost.split('') & %w(a c d e f h i j k l)).any?
  end
end
