require 'open-uri'

class Smfcorp

  # Smfcorp.new.process
  # BASE_URI = 'http://www.smfcorp.net/cartes/'

  EDITIONS_URLS = {
    "edition de base 2019"    => 'http://www.smfcorp.net/cartes/edition.php?id=179&language=FR',
    "la révolte eathérique"   => "http://www.smfcorp.net/cartes/edition.php?id=159&language=FR",
    "retour sur ravnica"      => "http://www.smfcorp.net/cartes/edition.php?id=111&language=FR",
    "ravnica"                 => "http://www.smfcorp.net/cartes/edition.php?id=56&language=FR",
    "le pacte des guildes"    => "http://www.smfcorp.net/cartes/edition.php?id=57&language=FR",
    "Dominaria"               => "http://www.smfcorp.net/cartes/edition.php?id=182&language=FR",
    "Master 25"               => "http://www.smfcorp.net/cartes/edition.php?id=181&language=FR",
    "Rivals of ixalan"        => "http://www.smfcorp.net/cartes/edition.php?id=176&language=FR",
    "Iconic master"           => "http://www.smfcorp.net/cartes/edition.php?id=174&language=FR",
    "Ixalan"                  => "http://www.smfcorp.net/cartes/edition.php?id=172&language=FR",
    "L'age de la destruction" => "http://www.smfcorp.net/cartes/edition.php?id=167&language=FR",
    "Amonkhet"                => "http://www.smfcorp.net/cartes/edition.php?id=161&language=FR",
    "Kaladesh"                => "http://www.smfcorp.net/cartes/edition.php?id=158&language=FR",
    "La lune hermitique"      => "http://www.smfcorp.net/cartes/edition.php?id=154&language=FR",
    "Eternal master"          => "http://www.smfcorp.net/cartes/edition.php?id=155&language=FR",
    "Tenebre sur inistrad"    => "http://www.smfcorp.net/cartes/edition.php?id=151&language=FR",
    # "" => "",
  }

  def process
    @client = HTTPClient.new(default_header: { "Accept-Language" => "fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7" })
    error   = {}

    # ExtensionSet.all.destroy_all
    # Card.all.destroy_all

    EDITIONS_URLS.each do |name, url|
      set        = ExtensionSet.create(name: name)
      cards_urls = url
      cards_urls = retrieve_cards_urls(url)
      error_urls = []

      cards_urls.each do |card_url|
        data = retrieve_card_data(card_url)
        if data.present?
          Card.create(data.merge(extension_set_id: set.id))
        else
          error_urls << card_url
        end
      end
      error[:extension_set_id] = error_urls
    end
    File.open("#{Rails.root.to_s}/error.json", 'w+') do |f|
      f.write(error.to_s)
    end
  end

  def retrieve_cards_urls(set_url)
    response    = @client.get(set_url)
    html        = Nokogiri::HTML(response.body)
    cards_links = []

    html.css('.divTableColumn:nth-child(2)').each do |line|
      cards_links << "http://www.smfcorp.net/cartes/#{line.css('a').first.attribute('href').value}"
    end

    cards_links
  end

  def retrieve_card_data(card_url)
    card_data         = {}
    response          = @client.get(card_url)
    html              = Nokogiri::HTML(response.body)
    gatherer_link     = html.css('#blocLiensExternes').css('a').first.attribute('href').value
    response          = @client.get gatherer_link
    card_gatherer_id  = Nokogiri::HTML(response.body).css('a').first.attribute('href').value.split('%3d').last
    gatherer_link     = "http://gatherer.wizards.com/Pages/Card/Details.aspx?printed=true&multiverseid=#{card_gatherer_id}"
    response          = @client.get gatherer_link
    html              = Nokogiri::HTML response.body

    if (children = html.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_nameRow div.value').first&.children)
      name_fr     = children.first.text.strip
      cmc         = html.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_cmcRow div.value').first&.children&.first&.text&.strip
      type        = html.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_typeRow div.value').first.children.first.text.strip
      text_result = ''
      texts       = html.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_textRow div.value').first&.children
      if texts
        texts.each do |text|
          text_result << " #{text&.text&.strip}"
        end
      end
      num         = html.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_numberRow div.value').first.children.first.text.strip
      artist_name = html.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_artistRow div.value').first.children.first.text.strip
      rarity      = html.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_rarityRow div.value').first.css('span').first.text.strip
      image_path  = "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=#{card_gatherer_id}&type=card"

      cost = ''
      if cmc.present?
        html.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_manaRow div.value').first.css('img').each do |img|
          cost << retrieve_color(img.attribute('alt').value)
        end
      end

      {
        name_fr:        name_fr,
        mana_cost:      cost,
        cmc:            cmc,
        detailed_type:  type,
        text:           text_result&.strip,
        rarity:         retrieve_rarity(rarity),
        number_in_set:  num.to_i,
        artist_name:    artist_name,
        gatherer_link:  gatherer_link,
        gatherer_id:    card_gatherer_id,
        image:          open(image_path)
      }
    else
      nil
    end
  end

  def retrieve_color(value)
    case value
    when 'White'
      'w'
    when 'Red'
      'r'
    when 'Green'
      'g'
    when 'Black'
      'b'
    when 'Blue'
      'u'
    when'White or Blue'
      'a'
    when'Blue or Black'
      'c'
    when'Black or Red'
      'd'
    when'Red or Green'
      'e'
    when'Green or White'
      'f'
    when'White or Black'
      'h'
    when'Blue or Red'
      'i'
    when'Black or Green'
      'j'
    when'Red or White'
      'k'
    when'Green or Blue'
      'l'
    when'Two or White'
      'm'
    when'Two or Blue'
      'n'
    when'Two or Black'
      'o'
    when'Two or Red'
      'p'
    when'Two or Green'
      'k'
    else
      value
    end
  end

  def retrieve_rarity(value)
    case value
    when 'Mythic Rare'
      4
    when 'Uncommon'
      2
    when 'Rare'
      3
    when 'Common'
      1
    else
      1
    end
  end
end
