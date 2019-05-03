# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def update
    @user.update(user_params)
    redirect_to user_account_path
  end

  protected

  def user_params
    params.require('user').permit(:nickname, :presentation)
  end
end
