class Admin::WelcomeController < AdminController

  def index
  end

  def deck_validity
    Format::Validator.call
    redirect_to admin_root_path
  end
end
