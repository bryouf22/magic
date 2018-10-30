class Admin::ExtensionSetsController < AdminController

  def index
    @extensions = ExtensionSet.all.order('set_type ASC, release_date DESC')
    set_by_type
  end

  def show
    @set = ExtensionSet.find(params[:id])
  end

  def edit
    @set = ExtensionSet.find(params[:id])
  end

  def update
    # FIXME update release_date doesn t work
    @set = ExtensionSet.find(params[:id])

    if @set.update_attributes(update_params)
      redirect_to admin_extension_sets_path
    else
      render :edit
    end
  end

  private

  def update_params
    params.require(:extension_set).permit(:name, :set_type, :release_date, :set_visual, :commun_logo, :uncommun_logo, :rare_logo, :mythic_logo)
  end
end
