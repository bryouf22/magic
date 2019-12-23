class Admin::BlocsController < AdminController
  def create
    Bloc.create
    redirect_to admin_blocs_path
  end

  def index
    @blocs = Bloc.all.order('release_date ASC')
  end

  def destroy
  end
end
