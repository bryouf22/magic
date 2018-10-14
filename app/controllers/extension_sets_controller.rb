class ExtensionSetsController < ApplicationController

  after_action :list_by_colors, only: :show

  def index
    @extensions = ExtensionSet.all
  end

  def show
    @set    = ExtensionSet.where(slug: params[:slug]).first!
    @cards  = @set.cards.order('name_fr_clean ASC')
    list_by_colors
    render :visual if view == 'visual'
  end

  def edit
    @set = ExtensionSet.find(params[:id])
  end

  def update
    @set = ExtensionSet.find(params[:id])

    if @set.update_attributes(update_params)
      redirect_to extension_set_path(@set)
    else
      render :edit
    end
  end

  private

  def view
    params[:view].presence || :classic
  end

  def update_params
    params.require(:extension_set).permit(:name, :release_date, :set_visual, :commun_logo, :uncommun_logo, :rare_logo, :mythic_logo)
  end
end
