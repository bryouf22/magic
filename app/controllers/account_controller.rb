class AccountController < ApplicationController

  add_breadcrumb "home", :root_path
  add_breadcrumb "Mon compte", :user_account_path

  def index
  end

end
