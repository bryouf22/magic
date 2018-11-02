class ExtensionSetsController < ApplicationController

  after_action :list_by_colors, only: :show

  def index
    set_by_type(ExtensionSet.all)
  end

  def show
    @set    = ExtensionSet.where(slug: params[:slug]).first!
    @cards  = @set.cards.order('name_fr_clean ASC')
    list_by_colors
    render :visual if view == 'visual'
  end

  private

  def view
    params[:view].presence || :classic
  end
end
