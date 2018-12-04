class ImportCard
  require 'open-uri'

  def initialize(card_url, extension_set_id)
    client  = HTTPClient.new(default_header: { "Accept-Language" => "fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7" }).get(card_url)
    @doc    = Nokogiri::HTML(client.body)
    g_id    = gatherer_id(card_url)

    if extension_set_id.nil?
      puts card_url
      value = @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_setRow .value a').last&.text&.squish
      value = @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_ctl02_setRow .value a').last&.text&.squish if value.nil?
      GathererScraper::EXTENSION_NAME.each do |fail_set|
        if value.parameterize == fail_set.parameterize
          extension_set_id = GathererScraper.find_or_create(fail_set)
          break
        end
      end
    end
    if @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_cardComponent1 div').first.present? && @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_cardComponent0 div').first.present?
      ImportDoubleCard.new(card_url, extension_set_id)
    else
      begin
        card = Card.create({
          name_fr:            name_fr,
          name:               name,
          extension_set_id:   extension_set_id,
          detailed_type:      detailed_type,
          rarity:             rarity,
          text:               retrieve_text,
          cmc:                cmc,
          mana_cost:          mana_cost,
          image:              image(g_id),
          power:              power,
          defense:            defense,
          artist_name:        artist_name,
          number_in_set:      number_in_set,
          gatherer_link:      card_url,
          gatherer_id:        g_id,
          image_fr:           image_fr,
          type_fr:            type_fr,
          text_fr:            text_fr,
          flavor_text:        flavor_text,
          flavor_text_fr:     flavor_text_fr,
          power_str:          power_str,
          defense_str:        defense_str,
          color_indicator:    color_indicator,
          loyalty:            loyalty,
        })
        puts "#{card.name} imported"
        if (gatherer_url = GathererCardUrl.where(url: card_url, extension_set_id: extension_set_id).first)
          gatherer_url.destroy
        end
      rescue
        puts "#{card_url} failed"
        if GathererCardUrl.where(url: card_url, extension_set_id: extension_set_id).none?
          GathererCardUrl.create(url: card_url, extension_set_id: extension_set_id)
        end
      end
    end
  end

  private

  def name_fr
  end

  def name
    @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_nameRow .value').first.text.squish
  end

  def detailed_type
    @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_typeRow .value').first.text.squish
  end

  def rarity
    rarity_text = @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_rarityRow .value').first.text.squish.downcase
    case rarity_text
    when 'mythic rare'
      :mythic
    when 'special'
      :mythic
    when 'basic land'
      :common
    else
      rarity_text.to_sym
    end
  end

  def build_text_from(tag, text)
    output = text
    if tag.children.any?
      tag.children.each do |child_tag|
        output += build_text_from(child_tag, '')
      end
    elsif tag.name == 'text'
      return '' if tag.text.squish.blank?
      output += "#{tag.text.squish}\n"
    elsif tag.name == 'img'
      output += "#{output}#{retrieve_symbol(tag.attribute('alt').value)}"
    end
    output
  end

  def retrieve_text
    if @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_textRow .value').first
      result = build_text_from(@doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_textRow .value').first, '')
    else
      nil
    end
  end

  def cmc
    @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_cmcRow .value').first&.text&.squish
  end

  def mana_cost
    @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_manaRow .value img').collect do |cost_img|
      retrieve_color(cost_img.attribute('alt').value)
    end.join
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
      'q'
    when 'Variable Colorless'
      'x'
    when 'Phyrexian White'
      's'
    when 'Phyrexian Blue'
      't'
    when 'Phyrexian Black'
      'v'
    when 'Phyrexian Red'
      'z'
    when 'Phyrexian Green'
      'y'
    else
      value
    end
  end

  def retrieve_symbol(value)
    "{#{retrieve_color(value).downcase}}"
  end

  def image(id)
    open("http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=#{id}&type=card")
  end

  def power
  end

  def defense
  end

  def artist_name
    @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_artistRow .value').first&.text&.squish
  end

  def number_in_set
    @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_numberRow .value').first&.text&.squish
  end

  def gatherer_id(card_url)
    card_url.match(/multiverseid=(\d+)/)[1]
  end

  def image_fr
  end

  def type_fr
  end

  def text_fr
  end

  def flavor_text
    @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_flavorRow .value').first&.text&.squish
  end

  def flavor_text_fr
  end

  def power_str
    @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_ptRow .value').first&.text&.squish&.split('/')&.first&.squish
  end

  def defense_str
    @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_ptRow .value').first&.text&.squish&.split('/')&.last&.squish
  end

  def color_indicator
    @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_colorIndicatorRow .value').first&.text&.squish
  end

  def loyalty
    if (power_thougtness = @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_ptRow .value').first&.text&.squish)
      power_thougtness.include?('/') ? nil : power_thougtness
    end
  end
end
