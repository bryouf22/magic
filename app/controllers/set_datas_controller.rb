class SetDatasController < ApplicationController

  def index
    @sets = SetData.order(release_date: :desc).page(params[:page]).per(100)
  end

  def show
    @set = SetData.find(params['id'])
    @cards = @set.card_datas.order(number: :asc)
    @back_page = params['back_page'].presence
  end

  def visuals
    @set = SetData.find(params['id'])
    @cards = @set.card_datas.order(number: :asc)
    @back_page = params['back_page'].presence
  end
end
