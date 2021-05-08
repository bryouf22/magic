class JsonTokensController < ApplicationController

  add_breadcrumb 'Mtgjson.com', :json_sets_path

  def show
    @set = JsonSet.find(params['json_set_id'])
    @token = JsonToken.find(params['id'])

    add_breadcrumb @set.name, json_set_path(@set)
    add_breadcrumb @token.name
  end
end
