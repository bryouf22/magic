class ExtensionSets::CardsController < ApplicationController

  def show
    @set  = ExtensionSet.find(params[:extension_set_id])
    @card = @set.cards.where(id: params[:id]).first.decorate
  end
end
