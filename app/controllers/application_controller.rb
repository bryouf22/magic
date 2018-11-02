class ApplicationController < ActionController::Base

  private

  def set_by_type(extensions)
    @_sets           ||= extensions.where(set_type: nil)
    @masterpieces    ||= extensions.masterpiece
    @block_sets      ||= extensions.block_set
    @basic_editions  ||= extensions.basic_edition
    @from_the_vaults ||= extensions.from_the_vault
    @dual_decks      ||= extensions.dual_deck
    @reiditions      ||= extensions.reedition
    @premium_decks   ||= extensions.premium_deck
    @humouristics    ||= extensions.humouristic
    @starters        ||= extensions.starter
    @others          ||= extensions.other
    @onlines         ||= extensions.online
  end

  def list_by_colors(cards)
    @white_cards              ||= cards.only_white.decorate
    @blue_cards               ||= cards.only_blue.decorate
    @black_cards              ||= cards.only_black.decorate
    @red_cards                ||= cards.only_red.decorate
    @green_cards              ||= cards.only_green.decorate
    @gold_cards               ||= cards.gold.decorate
    @colorless_artefact_cards ||= cards.colorless_artefact.decorate
    @land_cards               ||= cards.land.decorate
  end
end
