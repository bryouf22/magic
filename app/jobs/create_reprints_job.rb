class CreateReprintsJob < ApplicationJob
  queue_as :default

  def perform(set_id = nil)
    if set_id.present?
      Card.where(extension_set_id: set_id).each do |card|
        create_unless_exist(card)
      end
    else
      Card.find_each do |card|
        create_unless_exist(card)
      end
    end
  end

  private

  def create_unless_exist(card)
    Card.where(name: card.name).where.not(id: card.id).find_each do |same_card|
      Reprint.create(card_id: card.id, reprint_card_id: same_card.id) if Reprint.where(card_id: card.id, reprint_card_id: same_card.id).none?
    end
  end
end
