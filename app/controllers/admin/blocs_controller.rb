class Admin::BlocsController < AdminController
  skip_before_action :verify_authenticity_token, only: :bloc_order

  def create
    Bloc.create
    redirect_to admin_blocs_path
  end

  def index
    @blocs = Bloc.all.order('bloc_order ASC')
  end

  def destroy
  end

  def bloc_order
    params['bloc'].each_with_index do |bloc_id, index|
      Bloc.find(bloc_id).update_attributes(bloc_order: index + 1)
    end
    render body: nil, status: 200
  end
end
