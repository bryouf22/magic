require 'open-uri'
require 'uri'

class ImportOtherLandVersion
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  def self.process
    client  = HTTPClient.new(default_header: { "Accept-Language" => "fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7" })

    @urls =  []

    Card.basic_lands.each do |land|
      puts "retrieveing : #{land.name} (#{land.extension_set.name})"
      result = client.get(land.gatherer_link.sub('https', 'http').sub('http', 'https'))
      @doc = Nokogiri::HTML(result.body)
      retrieve_otherversion_links
    end
    remove_existing_card_url!
    binding.pry
    @urls.each do |card_url|
      ImportCard.new(card_url, nil)
    end
  end

  def self.retrieve_otherversion_links
    @urls += @doc.css('.variationLink').collect { |a_tag| "https://gatherer.wizards.com#{a_tag.attribute('href')}" }
  end

  def self.remove_existing_card_url!
    @urls.each do |url|
      if Card.basic_lands.where(gatherer_id: gatherer_id(url)).any?
        @urls.delete(url)
      end
    end
  end

  def self.gatherer_id(card_url)
    card_url.match(/multiverseid=(\d+)/)[1]
  end
end
