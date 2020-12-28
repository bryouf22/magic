class Admin::ExtensionSets::CardsController < AdminController

  def show
    @set = ExtensionSet.find(params['extension_set_id'])
    @card = Card.find(params['id'])
  end

  def update
    #
    # USE INTERACTOR HERE
    #
  end

  private

  def card_params
    params.require(:card).permit(:name, :mana_cost, :color_indicator, :detailed_type, :card_type, :rarity, :subtypes, :extension_set_id, :text, :flavor_text, :artist_name, :number_in_set, :gatherer_id, :power_str, :defense_str, :loyalty, :is_double_card, :alternative_type, :image_url)
  end
end
