class Admin::CardsController < AdminController

  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  def new
    if params['from'].present?
      @card = Card.new(Card.find(params['from']).attributes)
      @from = params['from']
    else
      @card = Card.new
    end
  end

  def without_image
    @cards = Card.where(has_image: false).decorate
  end

  def add_version
    version_params = params.require(:add_version).permit(:card_id, :url)
    card = Card.find(version_params['card_id'])

    AlternateFrame.create(card_id: card.id, image: open(version_params['url'])) # HERE
    redirect_to extension_set_card_path(slug: card.extension_set.slug, id: card.id)
  end

  def create
    if params['from'].present? && params['from'] == 'card_url'
      if (@card = CardServices::CreateFromUrl.call(card_from_url_params).card)
        return redirect_to admin_extension_set_gatherer_card_urls_path(@card.extension_set_id)
      end
    else
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
      return redirect_to admin_extension_set_path(@card.extension_set)
    end
  end

  def index
    @blocs = Bloc.all.order('release_date ASC')
  end

  def duplicate
    @card = Card.find(params['id'])
  end

  def destroy
  end

  def create_duplicate
    if (@card = Card.find(params['id']))
      card_attribute = @card.attributes.except('created_at', 'updated_at', 'gatherer_id', 'gatherer_link', 'id')
      card_attribute.merge!(card_params)
      card_attribute.merge!(image: open(card_attribute['image']))
      @card = Card.create(card_attribute)
      create_reprints(@card)
      extension_set = @card.extension_set
      extension_set.update(card_count: extension_set.card_count.to_i + 1, reprint_count: extension_set.reprint_count.to_i + 1)
      redirect_to card_path(@card)
    end
  end

  private

  def card_from_url_params
    params.require(:card).permit(:name,
                                 :mana_cost,
                                 :color_indicator,
                                 :detailed_type,
                                 :card_type,
                                 :rarity,
                                 :subtypes,
                                 :extension_set_id,
                                 :text,
                                 :flavor_text,
                                 :artist_name,
                                 :number_in_set,
                                 :gatherer_id,
                                 :power_str,
                                 :defense_str,
                                 :loyalty,
                                 :is_double_card,
                                 :alternative_type,
                                 :image_url)
  end

  def create_reprints(card)
    Card.where(name: card.name).where.not(id: card.id).find_each do |same_card|
      if Reprint.where(card_id: card.id, reprint_card_id: same_card.id).none?
        Reprint.create(card_id: same_card.id, reprint_card_id: card.id)
        Reprint.create(card_id: card.id, reprint_card_id: same_card.id)
      end
    end
  end

  def card_params
    params.require('card').permit(:name, :extension_set_id, :image, :gatherer_id, :number_in_set)
  end
end
