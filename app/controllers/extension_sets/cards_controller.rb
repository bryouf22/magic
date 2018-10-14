class ExtensionSets::CardsController < ApplicationController

  def show
    @set  = ExtensionSet.where(slug: params[:slug]).first!
    @card = @set.cards.where(id: params[:id]).first.decorate
  end
end
