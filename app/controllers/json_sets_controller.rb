class JsonSetsController < ApplicationController

  def index
    @sets = JsonSet.order(release_date: :desc).page(params[:page]).per(100)
  end

  def show
    @set = JsonSet.find(params['id'])
    @cards = @set.json_cards.order(number: :asc)
    @tokens = @set.json_tokens.order(name: :asc)
    @back_page = params['back_page'].presence
  end

  def visuals
    @set = JsonSet.find(params['id'])
    @cards = @set.json_cards.order(number: :asc)
    @tokens = @set.json_tokens.order(name: :asc)
    @back_page = params['back_page'].presence
  end
end
