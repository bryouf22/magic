class CardsController < ApplicationController

  before_action :authenticate_user!, only: :add_to

  def show
    @card = Card.find(params[:id]).decorate
  end

  def add_to
    case action_params
    when 'collection'
    when 'wishlist'
    when 'deck'
    end
    redirect_to root_path
  end

  private

  def action_params
    params.require(:add).permit(:to)[:to]
  end

  def card_ids
    params.require(:card_ids)
  end
end
