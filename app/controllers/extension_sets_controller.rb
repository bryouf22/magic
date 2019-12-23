class ExtensionSetsController < ApplicationController

  add_breadcrumb "home", :root_path
  add_breadcrumb "Extensions", :extension_sets_path

  def index
    set_meta_tags title: "Extensions"
    @block_sets = []
    ExtensionSet.set_types.to_a.collect { |type| type.last }.each do |type|
      next if ExtensionSet.where(set_type: type).none?
      if (bloc_ids = ExtensionSet.where(set_type: type).collect(&:bloc_id)).any?
        @block_sets << Bloc.where(id: bloc_ids).reorder('release_date ASC').collect { |bloc_id| ExtensionSet.where(set_type: type).where(bloc_id: bloc_id).reorder('extension_sets.release_date ASC') }
      else
        @block_sets << ExtensionSet.where(set_type: type).reorder('extension_sets.release_date ASC')
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
    list_by_colors(@set.cards.order('name_clean ASC'))
    add_breadcrumb @set.name, extension_set_path(slug: @set.slug)
    set_meta_tags title: @set.name
    render :visual if view_mode == 'images'
  end

  def search_params
    params.require('extension_set_search').permit(:term)
  end
end
