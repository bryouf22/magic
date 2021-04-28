class JsonCardsController < ApplicationController
  def show
    @set = JsonSet.find(params['json_set_id'])
    @card = JsonCard.find(params['id'])
  end
end
