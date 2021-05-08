class ExtensionSets::CardsController < ApplicationController

  add_breadcrumb 'Extensions', :extension_sets_path

  def show
    @set  = ExtensionSet.where(slug: params[:slug]).first!
    @card = @set.cards.where(id: params[:id]).first&.decorate
    if !@card && @set.name.parameterize == 'time-spiral'
      @card = ExtensionSet.where(slug: 'time-spiral-timeshifted').first.cards.where(id: params[:id]).first&.decorate
    end
    add_breadcrumb @set.name, extension_set_path(slug: @set.slug)
    add_breadcrumb @card.name, extension_set_card_path(slug: @set.slug, id: @card.id)
    set_meta_tags title: @card.name
  end

  def search_num
    @set  = ExtensionSet.where(slug: params[:slug]).first!
    if (@card = @set.cards.where(number_in_set: params[:card][:num]).first)
      redirect_to extension_set_card_path(slug: @set.slug, id: @card.id)
    end
  end
end
