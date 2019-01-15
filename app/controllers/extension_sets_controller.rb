class ExtensionSetsController < ApplicationController

  def index
    set_by_type(ExtensionSet.all)
  end

  def search
    @term     = search_params[:term]
    @search   = ExtensionSetSearch.new(search_params)
    @results  = @search.results.limit(20)
    respond_to do |format|
      format.json do
        json_result = []
        @results.each do |extension_set|
          json_result << { id: extension_set.id, text: extension_set.name }
        end
        render json: json_result.to_json
      end
      format.html
    end
  end

  def show
    @set = ExtensionSet.where(slug: params[:slug]).first!
    list_by_colors(@set.cards.order('name_fr_clean ASC'))
    render :visual if view == 'visual'
  end

  def search_params
    params.require('extension_set_search').permit(:term)
  end
end
