class JsonCardsController < ApplicationController

  add_breadcrumb 'Mtgjson.com', :json_sets_path

  def show
    @set = JsonSet.find(params['json_set_id'])
    @card = JsonCard.find(params['id'])

    add_breadcrumb @set.name, json_set_path(@set)
    add_breadcrumb @card.name
  end
end
