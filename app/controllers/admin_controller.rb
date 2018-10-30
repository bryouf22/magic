class AdminController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_admin_user
  ADMIN_EMAILS = ['jean@val.jean', 'bryouf@free.fr']

  layout 'admin'

  private

  def ensure_admin_user
    redirect_to root_path unless current_user.present? && ADMIN_EMAILS.include?(current_user.email)
  end

end
