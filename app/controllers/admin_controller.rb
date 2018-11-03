class AdminController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_admin_user

  private

  def ensure_admin_user
    redirect_to root_path unless current_user.present? && current_user.is_admin?
  end
end
