class Admin::CardsController < AdminController
  def new
    if params['from'].present?
      @card = Card.new(Card.find(params['from']).attributes)
      @from = params['from']
    else
      @card = Card.new
    end
  end

  def create
    @card = Card.create(card_params)
    if (card_from = Card.where(id: params['card']['from_card_id']).first)
      @card.update(
        card_type: card_from.card_type,
        detailed_type: card_from.detailed_type,
        rarity: card_from.rarity,
        text: card_from.text,
        cmc: card_from.cmc,
        mana_cost: card_from.mana_cost,
        color_ids: card_from.color_ids,
        artist_name: card_from.artist_name,
        flavor_text: card_from.flavor_text,
        power_str: card_from.power_str,
        defense_str: card_from.defense_str,
        color_indicator: card_from.color_indicator,
        loyalty: card_from.loyalty,
        format: card_from.format,
        first_edition: card_from.first_edition
      )
    end
    create_reprints(@card)
    redirect_to admin_extension_set_path(@card.extension_set)
  end

  def index
    @blocs = Bloc.all.order('release_date ASC')
  end

  def destroy
  end

  private

  def create_reprints(card)
    Card.where(name: card.name).where.not(id: card.id).find_each do |same_card|
      if Reprint.where(card_id: card.id, reprint_card_id: same_card.id).none?
        Reprint.create(card_id: card.id, reprint_card_id: same_card.id)
      end
    end
  end

  def card_params
    params.require('card').permit(:name, :extension_set_id, :image, :gatherer_id, :number_in_set)
  end
end
