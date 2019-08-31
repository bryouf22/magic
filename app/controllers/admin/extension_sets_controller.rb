class Admin::ExtensionSetsController < AdminController

  before_action :find_set, only: [:show, :edit, :update]

  def index
    @blocs = Bloc.all.order('blocs.bloc_order ASC')
    set_by_type(ExtensionSet.all.order('set_type ASC, release_date DESC'))
  end

  def show
    list_by_colors(@set.cards.order('name_fr_clean ASC'))
  end

  def edit
  end

  def update
    if @set.update_attributes(update_params)
      redirect_to admin_extension_sets_path
    else
      render :edit
    end
  end

  private

  def find_set
    @set = ExtensionSet.find(params[:id])
  end

  def update_params
    params.require(:extension_set).permit(:name, :set_type, :release_date, :bloc_id, :order, :code)
  end
end
