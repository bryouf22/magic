class ImportDoubleCard
  require 'open-uri'

  def initialize(card_url, extension_set_id)
    if GathererCardUrl.where(url: card_url, extension_set_id: extension_set_id).none?
      GathererCardUrl.create(url: card_url, extension_set_id: extension_set_id)
    end

    # ImportCard.new("http://gatherer.wizards.com/Pages/Card/Details.aspx?printed=true&multiverseid=443095", ExtensionSet.first.id)
    # ImportCard.new("http://gatherer.wizards.com/Pages/Card/Details.aspx?printed=true&multiverseid=370457", ExtensionSet.first.id)
    # ImportCard.new("http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=423671", ExtensionSet.first.id)
    # ImportCard.new("http://gatherer.wizards.com/Pages/Card/Details.aspx?printed=true&multiverseid=370404", ExtensionSet.first.id)
    # ImportCard.new("http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=452976", ExtensionSet.first.id)
    # ImportCard.new("http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=78600", ExtensionSet.first.id)
  end
end
