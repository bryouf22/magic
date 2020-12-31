class Admin::ExtensionSets::CardsController < AdminController

  def show
    @set = ExtensionSet.find(params['extension_set_id'])
    @card = Card.find(params['id'])
  end

  def update
    #
    # USE INTERACTOR HERE
    #
    @card = Card.find(params['id'])
    if @card.update(card_params)
      redirect_to admin_extension_set_card_path(@card.extension_set_id, @card.id)
    else
    end
  end

  private

  def card_params
    params.require(:card).permit(:name, :mana_cost, :color_indicator, :detailed_type, :rarity, :extension_set_id,
      :text, :flavor_text, :artist_name, :number_in_set, :gatherer_id, :power_str, :defense_str, :loyalty, :is_double_card, :is_double_part, :alternative_type,
      :alternative_type, :specific_frame_type, :set_extra_card) # , :card_type, :subtypes, ::image_url)
  end
end
