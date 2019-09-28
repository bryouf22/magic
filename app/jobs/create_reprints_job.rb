class CreateReprintsJob < ApplicationJob
  queue_as :default

  def perform
    Card.find_each do |card|
      Card.where(name: card.name).where.not(id: card.id).find_each do |same_card|
        if Reprint.where(card_id: card.id, reprint_card_id: same_card.id).none?
          Reprint.create(card_id: card.id, reprint_card_id: same_card.id)
        end
      end
    end
  end
end
