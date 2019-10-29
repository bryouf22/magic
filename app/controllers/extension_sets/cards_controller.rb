class ExtensionSets::CardsController < ApplicationController

  add_breadcrumb "home", :root_path
  add_breadcrumb "Extensions", :extension_sets_path

  def show
    @set  = ExtensionSet.where(slug: params[:slug]).first!
    @card = @set.cards.where(id: params[:id]).first.decorate
    add_breadcrumb @set.name, extension_set_path(slug: @set.slug)
    add_breadcrumb @card.name, extension_set_card_path(slug: @set.slug, id: @card.id)
    set_meta_tags title: @card.name
  end
end
