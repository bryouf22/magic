class Admin::ExtensionSetsController < AdminController

  def index
    @blocs = Bloc.all.order('blocs.bloc_order ASC')
    set_by_type(ExtensionSet.all.order('set_type ASC, release_date DESC'))
  end

  def show
    @set = ExtensionSet.find(params[:id])
    list_by_colors(@set.cards.order('name_fr_clean ASC'))
  end

  def edit
    @set = ExtensionSet.find(params[:id])
  end

  def update
    @set = ExtensionSet.find(params[:id])

    if @set.update_attributes(update_params)
      redirect_to admin_extension_sets_path
    else
      render :edit
    end
  end

  private

  def update_params
    params.require(:extension_set).permit(:name, :set_type, :release_date, :set_visual, :commun_logo, :uncommun_logo, :rare_logo, :mythic_logo, :bloc_id, :order, :bad_visual)
  end
end
