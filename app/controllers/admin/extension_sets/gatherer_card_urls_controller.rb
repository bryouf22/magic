class Admin::ExtensionSets::GathererCardUrlsController < ApplicationController
  def index
    @set = ExtensionSet.find(params['extension_set_id'])
    @gatherer_card_urls = @set.gatherer_card_urls
  end
end
