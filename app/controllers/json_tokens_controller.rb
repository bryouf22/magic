class JsonTokensController < ApplicationController
  def show
    @set = JsonSet.find(params['json_set_id'])
    @token = JsonToken.find(params['id'])
  end
end
