class GathererScraper
  require 'open-uri'

  def initialize

  end

  def test
    client = HTTPClient.new(default_header: { "Accept-Language" => "fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7" })
    en_client = HTTPClient.new(default_header: { "Accept-Language" => "en-US;q=0.8,en;q=0.7" })

    url = 'http://gatherer.wizards.com/Pages/Search/Default.aspx?action=advanced&set=["Apocalypse"]'
    response = client.get(url)
    response_en = en_client.get(url)
    File.open("#{Rails.root.to_s}/gatherer.html", 'w+') do |f|
      f.write(response.body)
    end
    File.open("#{Rails.root.to_s}/gatherer_en.html", 'w+') do |f|
      f.write(response_en.body)
    end
  end
end
