class Admin::ExtensionSets::GathererCardUrlsController < ApplicationController
  def index
    @gatherer_card_urls = ExtensionSet.find(params['extension_set_id']).gatherer_card_urls
  end
end
