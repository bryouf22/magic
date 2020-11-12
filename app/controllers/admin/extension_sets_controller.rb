class Admin::ExtensionSetsController < AdminController
  before_action :find_set, only: %i[show edit update create_card]

  def index
    @sets = ExtensionSet.all.order('release_date DESC')
  end

  def show
    list_by_colors(@set.cards.order('name_clean ASC'))
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

  def new
    @set = ExtensionSet.new
  end

  def create_card
    @card = Card.new(extension_set_id: @set.id)
    if params['gatherer_url_id']
      @url = @set.gatherer_card_urls.where(id: params['gatherer_url_id']).first.url
    end
    add_breadcrumb 'home', :root_path
    add_breadcrumb 'Extensions', extension_sets_path
    add_breadcrumb @set.name, extension_set_path(@set.slug)
    add_breadcrumb 'Nouvelle carte'
  end

  def create
    ExtensionSet.create(update_params)
    redirect_to admin_extension_sets_path
  end

  def find_reeditions
    CreateReprintsJob.perform_now(params['id'].to_i)
    redirect_to admin_extension_set_path(params['id'])
  end

  def update_data
    ExtensionSet::Register.call(set_id: params['id'].to_i)
  end

  private

  def find_set
    @set = ExtensionSet.find(params[:id])
  end

  def update_params
    params.require(:extension_set).permit(:name, :set_type, :release_date, :bloc_id, :code)
  end
end
