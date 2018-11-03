class ExtensionSetsController < ApplicationController

  def index
    set_by_type(ExtensionSet.all)
  end

  def show
    @set = ExtensionSet.where(slug: params[:slug]).first!
    list_by_colors(@set.cards.order('name_fr_clean ASC'))
    render :visual if view == 'visual'
  end

  private

  def view
    params[:view].presence || :classic
  end
end
