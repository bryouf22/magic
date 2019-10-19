class Admin::ExtensionSetsController < AdminController
  before_action :find_set, only: %i[show edit update]

  def index
    @sets = ExtensionSet.all.order('release_date DESC')
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
