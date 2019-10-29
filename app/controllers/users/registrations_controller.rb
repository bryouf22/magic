# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def update
    @user.update(user_params)
    redirect_to user_account_path
  end

  def edit
    add_breadcrumb "home", :root_path
    add_breadcrumb "Mon compte", :user_account_path
    add_breadcrumb "Édition"
    set_meta_tags title: "Éditer mon compte"
  end

  protected

  def user_params
    params.require('user').permit(:nickname, :presentation)
  end
end
