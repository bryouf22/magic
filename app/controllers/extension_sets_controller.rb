class ExtensionSetsController < ApplicationController

  add_breadcrumb "home", :root_path
  add_breadcrumb "Extensions", :extension_sets_path

  def index
    @block_sets = []
    ExtensionSet.set_types.to_a.collect { |type| type.last }.each do |type|
      next if ExtensionSet.where(set_type: type).none?
      if (bloc_ids = ExtensionSet.where(set_type: type).collect(&:bloc_id)).any?
        @block_sets << Bloc.where(id: bloc_ids).reorder('bloc_order ASC').collect { |bloc_id| ExtensionSet.where(set_type: type).where(bloc_id: bloc_id).reorder('extension_sets.order ASC') }
      else
        @block_sets << ExtensionSet.where(set_type: type).reorder('extension_sets.order ASC')
      end
    end
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
    add_breadcrumb @set.name, extension_set_path(slug: @set.slug)
  end

  def search_params
    params.require('extension_set_search').permit(:term)
  end
end
