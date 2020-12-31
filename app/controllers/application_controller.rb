class ApplicationController < ActionController::Base
  helper_method :accessible?

  def accessible?
    false
  end

  private

  def set_by_type(extensions)
    @block_sets      ||= Bloc.order('blocs.release_date ASC')
    @_sets           ||= extensions.where(set_type: nil)
    @masterpieces    ||= extensions.masterpiece
    @sets            ||= extensions.block_set.where(bloc_id: nil)
    @basic_editions  ||= extensions.basic_edition
    @from_the_vaults ||= extensions.from_the_vault
    @dual_decks      ||= extensions.dual_deck
    @reiditions      ||= extensions.reedition
    @premium_decks   ||= extensions.premium_deck
    @humouristics    ||= extensions.humouristic
    @starters        ||= extensions.starter
    @others          ||= extensions.other
    @onlines         ||= extensions.online
    @commander       ||= extensions.commander
    @guild_kit       ||= extensions.guild_kit
  end

  def list_by_colors(cards)
    @white_cards              ||= cards.only_white.decorate
    @blue_cards               ||= cards.only_blue.decorate
    @black_cards              ||= cards.only_black.decorate
    @red_cards                ||= cards.only_red.decorate
    @green_cards              ||= cards.only_green.decorate
    @gold_cards               ||= cards.gold.decorate
    @gold_not_hybrid_cards    ||= cards.gold_not_hybrids.not_double.decorate
    @hybrid_cards             ||= cards.hybrids.not_double.decorate
    @colorless_artefact_cards ||= cards.colorless_artefact.decorate
    @land_cards               ||= cards.lands.decorate
    @colorless_non_artefact   ||= cards.colorless_non_artefact.decorate
    @double_cards             ||= cards.doubles.decorate
    @hybrid_cards             ||= cards.hybrids.decorate
  end

  def view_mode
    params[:view].presence || :list
  end
end
