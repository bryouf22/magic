class SetSpecificationToCards < ApplicationJob
  queue_as :default

  def perform(cards = [])
    cards = cards.presence || Card
    cards.find_each do |card|
      if card.has_alternative?
        card.update(is_double_card: true)
      elsif card.alternative?
        card.update(is_double_part: true)
      end
      card.update(hybrid: true) if hybrid_mana_cost?(card.mana_cost)
    end
    Alternative.all.find_each(&:set_type_to_card!)
  end

  private

  def hybrid_mana_cost?(mana_cost = '')
    (mana_cost.split('') & %w(a c d e f h i j k l)).any?
  end
end
