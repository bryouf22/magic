class AccountController < ApplicationController

  add_breadcrumb "home", :root_path
  add_breadcrumb "My account", :user_account_path

  def index
    set_meta_tags title: "My account"
  end

end
