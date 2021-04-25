class CardDatasController < ApplicationController
  def show
    @set = SetData.find(params['set_data_id'])
    @card = CardData.find(params['id'])
  end
end
