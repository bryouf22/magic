class JsonSetsController < ApplicationController

  add_breadcrumb 'Mtgjson.com', :json_sets_path

  def index
    @sets = JsonSet.order(release_date: :desc).page(params[:page]).per(100)
  end

  def show
    @set    = JsonSet.find(params['id'])
    @cards  = @set.json_cards.order(sort_number: :asc, number: :asc)
    @tokens = @set.json_tokens.order(sort_number: :asc, number: :asc)

    add_breadcrumb @set.name, json_set_path(@set)
  end

  def visuals
    @set    = JsonSet.find(params['id'])
    @cards  = @set.json_cards.order(sort_number: :asc, number: :asc)
    @tokens = @set.json_tokens.order(sort_number: :asc, number: :asc)

    add_breadcrumb @set.name, json_set_path(@set)
    add_breadcrumb 'Gallerie'
  end
end
