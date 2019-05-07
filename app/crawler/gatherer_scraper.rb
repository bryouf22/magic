class GathererScraper
  require 'open-uri'
  require 'uri'

  ROOT_URL = "http://gatherer.wizards.com/Pages"

  # GathererScraper.reset_and_restart
  def self.reset_and_restart
    #Card.all.destroy_all
    #ExtensionSet.all.destroy_all
    self.process
  end

  # javascript
  # elements = document.querySelectorAll('table.compact tr.cardItem td.name a');
  # results = [];
  # for(n = 0; n < elements.length; n++) {
  #   results.push(elements[n].getAttribute('href'));
  # }
  # results;

  # GathererScraper.test
  def self.test
    urls = [
      "http://gatherer.wizards.com/Pages/Search/Default.aspx?page=##PAGE##&output=compact&action=advanced&set=[\"Apocalypse\"]",
      "http://gatherer.wizards.com/Pages/Search/Default.aspx?page=##PAGE##&output=compact&action=advanced&set=[\"Dissension\"]",
      "http://gatherer.wizards.com/Pages/Search/Default.aspx?page=##PAGE##&output=compact&action=advanced&set=[\"Invasion\"]",
      "http://gatherer.wizards.com/Pages/Search/Default.aspx?page=##PAGE##&output=compact&action=advanced&set=[\"Planar+Chaos\"]",
    ]
    urls.each do |url|
      page        = -1
      card_links  = []
      loop do
        page    += 1
        url_paginate = url.sub('##PAGE##', page.to_s)
        client  = HTTPClient.new(default_header: { "Accept-Language" => "en-US" }).get(url_paginate)
        doc     = Nokogiri::HTML(client.body)
        links = doc.css('table tr.cardItem td:first-child a').collect do |card_link|
          card_link.attribute('href').value.sub('..', ROOT_URL)
        end
        puts "#{links.count} cards found !"
        if page == 0 && links.count == 0
          File.open(URI.join("#{Rails.root}/#{url.parameterize}.html").to_s, 'w+') do |file|
            file.write doc.to_html.gsub('../..', 'http://gatherer.wizards.com').gsub('href="/Styles', 'href="http://gatherer.wizards.com/Styles')
          end
          break
        end
        break if card_links.include?(links.last)
        puts "continuing..."
        card_links += links
      end
      card_links.each do |card_url|
        ImportCard.reimport(card_url)
      end
    end
  end

  def self.process
    EXTENSION_NAME.each do |set_name|
      page        = -1
      card_links  = []
      loop do
        page    += 1
        url     = "http://gatherer.wizards.com/Pages/Search/Default.aspx?set=[#{set_name.gsub(' ', '+')}]&page=#{page}&output=compact"
        client  = HTTPClient.new(default_header: { "Accept-Language" => "fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7" }).get(url)
        doc     = Nokogiri::HTML(client.body)

        links = doc.css('table.compact tr.cardItem td.name a').collect do |card_link|
          card_link.attribute('href').value.sub('..', ROOT_URL)
        end
        puts "#{links.count} cards found !"
        if page == 0 && links.count == 0
          puts "no result found for #{set_name}"
          break
        end
        break if card_links.include?(links.last)
        puts "continuing..."
        card_links += links
      end
      set_id = self.find_or_create(set_name)
      self.import_cards(set_id, card_links)
    end
  end

  def self.import_gatherer_card_url
    GathererCardUrl.all.order("created_at DESC").each do |gatherer_url|
      ImportCard.new(gatherer_url.url, gatherer_url.extension_set_id)
    end
  end

  def self.find_or_create(set_name)
    if (set = ExtensionSet.where(name: set_name).first)
      puts "retrieving #{set_name}"
      set.id
    else
      ExtensionSet.create(name: set_name).id
    end
  end

  def self.import_cards(set_id, card_links)
    puts "#{set_id} : #{card_links.uniq.count}"
    card_links.each do |card_url|
      puts card_url
      ImportCard.new(card_url, set_id)
    end
  end

  def self.fail_sets
    @fail_sets ||= EXTENSION_NAME.collect do |set_name|
      ExtensionSet.where(name: set_name).first.cards.count.positive? ? nil : set_name
    end.compact
  end

  def self.import_failed_urls
    FAILED_URLS.each do |card_url|
      ImportCard.new(card_url, nil)
    end
  end

  def self.reimport_visual
    REIMPORT_URLS.each do |url|
      ImportCard.reimport(url)
    end
  end

  REIMPORT_URLS = [
    "http://gatherer.wizards.com/Pages/Card/Details.aspx?printed=false&multiverseid=84635"
  ]

  EXTENSION_NAME = [
    'War of the Spark'
  ]

  FAILED_URLS = [
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390645',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390646',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390647',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390713',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390714',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390715',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=406259',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=406260',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=406261',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=406290',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=406291',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=406292',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=406334',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=406335',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=406336',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=406368',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=406369',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=406370',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=406429',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=406430',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=406431',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=422020',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=422021',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=422011',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=422012',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=422017',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=422018',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=422008',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=422009',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=422014',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=422015',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=434167',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=434168',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=434158',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=434159',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=434164',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=434165',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=434155',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=434156',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=434161',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=434162',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=452005',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=452006',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=451996',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=451997',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=452002',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=452003',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=451993',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=451994',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=451999',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=452000',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443962',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443963',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443964',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443950',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443951',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443952',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443958',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443959',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443960',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443946',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443947',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443948',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443954',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443955',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443956',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=392576',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=392600',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=392626',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=392635',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=392675',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=273110',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=273109',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=273101',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=273100',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=273106',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=273107',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=273098',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=273097',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=273103',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=273104',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436035',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436036',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436037',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436038',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436024',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436025',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436026',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436032',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436033',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436034',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436020',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436021',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436022',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436028',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436029',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=436030',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=418892',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=418893',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=418883',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=418884',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=418889',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=418890',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=418880',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=418881',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=418886',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=418887',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158967',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158966',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158965',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158952',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158954',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158955',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158953',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158961',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158962',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158963',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158951',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158949',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158950',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158958',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158959',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=158957',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199554',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199555',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199553',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199542',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199543',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199541',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199551',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199550',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199549',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199537',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199539',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199538',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199544',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199547',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199546',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=199545',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=224737',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=224736',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=224738',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=224725',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=224726',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=224724',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=224734',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=224732',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=224733',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=224721',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=224720',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=224722',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=224729',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=224730',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=224728',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=263624',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=263622',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=263623',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=263610',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=263611',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=263612',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=263618',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=263619',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=263620',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=263608',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=263606',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=263607',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=263616',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=263615',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=263614',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331496',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331497',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331498',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331502',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331503',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331501',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331506',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331507',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331505',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331511',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331510',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331509',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331514',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331516',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331515',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=331517',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=399562',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=399678',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=399725',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=399585',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=399694',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=399772',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=399533',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=399598',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=399618',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=399649',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=399658',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=399783',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=399615',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=399663',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=399785',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=240525',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=240519',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=240522',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=240523',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=240517',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=240521',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=248008',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=248002',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=248005',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=248006',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=248000',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=248004',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177889',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177892',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177890',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177891',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177880',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177878',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177879',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177888',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177886',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177887',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177875',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177874',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177876',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177884',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177882',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=177883',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150316',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150315',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150314',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150303',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150304',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150302',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150312',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150310',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150311',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150297',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150299',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150298',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150300',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150308',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150306',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=150307',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=374611',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=374621',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=374684',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=374591',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=374719',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=374732',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=374605',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=374679',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=374742',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=374578',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=374650',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=374696',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=374604',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=374677',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=374702',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207018',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207019',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207024',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207020',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207022',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207023',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207021',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=206998',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=206999',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=206994',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=206997',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207000',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=206995',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=206996',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207016',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207011',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207013',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207014',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207010',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207012',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207015',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=206991',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=206992',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=206990',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=206989',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=206988',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=206987',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=206986',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207007',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207008',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207002',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207004',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207006',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207005',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=207003',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=461971',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=461971',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=461977',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=461977',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390572',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390573',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390574',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390575',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390613',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390614',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390615',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=427776',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=427777',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=427778',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=427767',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=427768',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=427769',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=427773',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=427774',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=427775',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=427764',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=427765',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=427766',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=427770',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=427771',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=427772',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=295704',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=295703',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=295695',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=295707',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=295701',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=295698',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=295700',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=295706',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=295705',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=295708',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=295699',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390536',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390537',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=390538',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=461972',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=461971',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=461972',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=461977',
'https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=461972',
]
end
