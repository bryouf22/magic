class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin_user

  def retrieve_data
    card_data = Crawler::RetrieveDataFromUrl.call(url: params['url']).card_data
    respond_to do |format|
      format.json do
        render json: card_data.to_json
      end
    end
  end

  private

  def ensure_admin_user
    redirect_to root_path unless current_user.present? && current_user.admin?
  end
end
