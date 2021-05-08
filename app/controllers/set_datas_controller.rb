class SetDatasController < ApplicationController

  def index
    @sets = SetData.order(release_date: :desc).page(params[:page]).per(100)
  end

  def show
    @set    = SetData.find(params['id'])
    @cards  = @set.card_datas.order(number: :asc)
  end

  def visuals
    @set    = SetData.find(params['id'])
    @cards  = @set.card_datas.order(number: :asc)
  end
end
