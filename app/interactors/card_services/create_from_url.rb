class CardServices::CreateFromUrl
  include Interactor

  def call
    if context.is_double_card == "false"
      card = Card.new
      card.name = context.name
      card.mana_cost = context.mana_cost
      card.color_indicator = context.color_indicator if context.color_indicator.present?
      card.detailed_type = context.detailed_type
      card.rarity = context.rarity
      card.extension_set_id = context.extension_set_id
      card.text = context.text
      card.flavor_text = context.flavor_text
      card.number_in_set = context.number_in_set
      card.gatherer_id = context.gatherer_id
      card.power_str = context.power_str
      card.defense_str = context.defense_str
      card.loyalty = context.loyalty
      card.artist_name = context.artist_name
      if context.image_url.present?
        card.remote_image_url = context.image_url
      else
        # TODO
      end
      0/0
      if card.save
        create_reprint(card)
        context.card = card
      end
    else
      # TODO
    end
  end

  def create_reprint(card)
    Card.where(name: card.name).where.not(id: card.id).find_each do |same_card|
      if Reprint.where(card_id: card.id, reprint_card_id: same_card.id).none?
        Reprint.create(card_id: card.id, reprint_card_id: same_card.id)
      end
      if Reprint.where(card_id: same_card.id, reprint_card_id: card.id).none?
        Reprint.create(card_id: same_card.id, reprint_card_id: card.id)
      end
    end
  end
end
