class AccountController < ApplicationController

  add_breadcrumb "home", :root_path
  add_breadcrumb "Mon compte", :user_account_path

  def index
    set_meta_tags title: "Mon compte"
  end

end
