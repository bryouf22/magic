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
    # "Aether Revolt",
    # "Alara Reborn",
    # "Alliances",
    # "Amonkhet",
    # "Antiquities",
    # "Apocalypse",
    # "Arabian Nights",
    # "Archenemy",
    # "Archenemy: Nicol Bolas",
    # "Avacyn Restored",
    # "Battle for Zendikar",
    # "Battle Royale Box Set",
    # "Battlebond",
    # "Beatdown Box Set",
    # "Betrayers of Kamigawa",
    # "Born of the Gods",
    # "Champions of Kamigawa",
    # "Chronicles",
    # "Classic Sixth Edition",
    # "Coldsnap",
    # "Commander 2013 Edition",
    # "Commander 2014",
    # "Commander 2015",
    # "Commander 2016",
    # "Commander 2017",
    # "Commander 2018",
    # "Commander Anthology",
    # "Commander Anthology 2018",
    # "Commander's Arsenal",
    # "Conflux",
    # "Conspiracy: Take the Crown",
    # "Core Set 2019",
    # "Dark Ascension",
    # "Darksteel",
    # "Dissension",
    # "Dominaria",
    # "Dragon's Maze",
    # "Dragons of Tarkir",
    # "Duel Decks Anthology, Divine vs. Demonic",
    # "Duel Decks Anthology, Elves vs. Goblins",
    # "Duel Decks Anthology, Garruk vs. Liliana",
    # "Duel Decks Anthology, Jace vs. Chandra",
    # "Duel Decks: Ajani vs. Nicol Bolas",
    # "Duel Decks: Blessed vs. Cursed",
    # "Duel Decks: Divine vs. Demonic",
    # "Duel Decks: Elspeth vs. Kiora",
    # "Duel Decks: Elspeth vs. Tezzeret",
    # "Duel Decks: Elves vs. Goblins",
    # "Duel Decks: Elves vs. Inventors",
    # "Duel Decks: Garruk vs. Liliana",
    # "Duel Decks: Heroes vs. Monsters",
    # "Duel Decks: Izzet vs. Golgari",
    # "Duel Decks: Jace vs. Chandra",
    # "Duel Decks: Jace vs. Vraska",
    # "Duel Decks: Knights vs. Dragons",
    # "Duel Decks: Merfolk vs. Goblins",
    # "Duel Decks: Mind vs. Might",
    # "Duel Decks: Nissa vs. Ob Nixilis",
    # "Duel Decks: Phyrexia vs. the Coalition",
    # "Duel Decks: Sorin vs. Tibalt",
    # "Duel Decks: Speed vs. Cunning",
    # "Duel Decks: Venser vs. Koth",
    # "Duel Decks: Zendikar vs. Eldrazi",
    # "Eighth Edition",
    # "Eldritch Moon",
    # "Eternal Masters",
    # "Eventide",
    # "Exodus",
    # "Explorers of Ixalan",
    # "Fallen Empires",
    # "Fate Reforged",
    # "Fifth Dawn",
    # "Fifth Edition",
    # "Fourth Edition",
    # "From the Vault: Angels",
    # "From the Vault: Annihilation (2014)",
    # "From the Vault: Dragons",
    # "From the Vault: Exiled",
    # "From the Vault: Legends",
    # "From the Vault: Lore",
    # "From the Vault: Realms",
    # "From the Vault: Relics",
    # "From the Vault: Transform",
    # "From the Vault: Twenty",
    # "Future Sight",
    # "Gatecrash",
    # "Global Series: Jiang Yanggu and Mu Yanling",
    # "Guild Kit: Boros",
    # "Guild Kit: Dimir",
    # "Guild Kit: Golgari",
    # "Guild Kit: Izzet",
    # "Guild Kit: Selesnya",
    # "Guildpact",
    # "Guilds of Ravnica",
    # "Homelands",
    # "Hour of Devastation",
    # "Ice Age",
    # "Iconic Masters",
    # "Innistrad",
    # "Invasion",
    # "Ixalan",
    # "Journey into Nyx",
    # "Judgment",
    # "Kaladesh",
    # "Khans of Tarkir",
    # "Legends",
    # "Legions",
    # "Limited Edition Alpha",
    # "Limited Edition Beta",
    # "Lorwyn",
    # "Magic 2010",
    # "Magic 2011",
    # "Magic 2012",
    # "Magic 2013",
    # "Magic 2014 Core Set",
    # "Magic 2015 Core Set",
    # "Magic Origins",
    # "Magic: The Gathering-Commander",
    # "Magic: The Gathering—Conspiracy",
    # "Masterpiece Series: Amonkhet Invocations",
    # "Masterpiece Series: Kaladesh Inventions",
    # "Masters 25",
    # "Masters Edition",
    # "Masters Edition II",
    # "Masters Edition III",
    # "Masters Edition IV",
    # "Mercadian Masques",
    # "Mirage",
    # "Mirrodin",
    # "Mirrodin Besieged",
    # "Modern Event Deck 2014",
    # "Modern Masters",
    # "Modern Masters 2015 Edition",
    # "Modern Masters 2017 Edition",
    # "Morningtide",
    # "Nemesis",
    # "New Phyrexia",
    # "Ninth Edition",
    # "Oath of the Gatewatch",
    # "Odyssey",
    # "Onslaught",
    # "Planar Chaos",
    # "Planechase",
    # "Planechase 2012 Edition",
    # "Planechase Anthology",
    # "Planeshift",
    # "Portal",
    # "Portal Second Age",
    # "Portal Three Kingdoms",
    # "Premium Deck Series: Fire and Lightning",
    # "Premium Deck Series: Graveborn",
    # "Premium Deck Series: Slivers",
    # "Promo set for Gatherer",
    # "Prophecy",
    # "Ravnica: City of Guilds",
    # "Return to Ravnica",
    # "Revised Edition",
    # "Rise of the Eldrazi",
    # "Rivals of Ixalan",
    # "Saviors of Kamigawa",
    # "Scars of Mirrodin",
    # "Scourge",
    # "Seventh Edition",
    # "Shadowmoor",
    # "Shadows over Innistrad",
    # "Shards of Alara",
    # "Signature Spellbook: Jace",
    # "Starter 1999",
    # "Starter 2000",
    # "Stronghold",
    # "Tempest",
    # "Tempest Remastered",
    # "Tenth Edition",
    # "The Dark",
    # "Theros",
    # "Time Spiral",
    # "Time Spiral \"Timeshifted\"",
    # "Torment",
    # "Ugin's Fate promos",
    # "Unglued",
    # "Unhinged",
    # "Unlimited Edition",
    # "Unstable",
    # "Urza's Destiny",
    # "Urza's Legacy",
    # "Urza's Saga",
    # "Vanguard",
    # "Vintage Masters",
    # "Visions",
    # "Weatherlight",
    # "Welcome Deck 2016",
    # "Welcome Deck 2017",
    # "Worldwake",
    # "Zendikar",
    # "Zendikar Expeditions",
    # "Ultimate Masters",
    # "Ravnica Allegiance",
    "Guilds of Ravnica Mythic Edition",
    "Gift Pack",
    "Game Night",
  ]

  FAILED_URLS = ["http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5797",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5789",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5793",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=8906",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=8908",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5687",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5739",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5657",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5565",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5590",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=10655",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5690",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5635",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5673",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5547",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5679",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=8871",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5689",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5833",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5861",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=7247",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=8849",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=8826",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5566",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=7168",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5850",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=8834",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5836",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=8907",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=8876",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5576",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5696",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5629",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=5825",
"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=8787"]
end
