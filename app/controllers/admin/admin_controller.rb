class Admin::AdminController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_admin_user

  private

  def ensure_admin_user
    redirect_to root_path if current_user.nil? || current_user.email != 'bryouf@free.fr'
  end
end
