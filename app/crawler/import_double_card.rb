class ImportDoubleCard
  require 'open-uri'
  def set_selectors
    if @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_cardComponent0 #ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_ctl01_componentWrapper').present?
      @card_1_selector = 'ctl01'
      @card_2_selector = 'ctl02'
    elsif @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_cardComponent0 #ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_ctl02_componentWrapper').present?
      @card_1_selector = 'ctl02'
      @card_2_selector = 'ctl03'
    elsif @doc.css('#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_cardComponent0 #ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_ctl03_componentWrapper').present?
      @card_1_selector = 'ctl03'
      @card_2_selector = 'ctl04'
    end
  end
  def initialize(card_url, extension_set_id)
    client  = HTTPClient.new(default_header: { "Accept-Language" => "fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7" }).get(card_url)
    @doc    = Nokogiri::HTML(client.body)
    @card_1 = nil
    @card_2 = nil

    set_selectors
    begin
      if Card.where(extension_set_id: extension_set_id, name: name).none? && Card.where(extension_set_id: extension_set_id, name: alt_name).none?
        @card_1 = Card.create({
          name:               name,
          extension_set_id:   extension_set_id,
          detailed_type:      detailed_type,
          rarity:             rarity,
          text:               retrieve_text,
          cmc:                cmc,
          mana_cost:          mana_cost,
          image:              image(gatherer_id, false),
          artist_name:        artist_name,
          number_in_set:      number_in_set,
          gatherer_link:      card_url,
          gatherer_id:        gatherer_id,
          flavor_text:        flavor_text,
          power_str:          power_str,
          defense_str:        defense_str,
          color_indicator:    color_indicator,
          loyalty:            loyalty,
        })
        @card_2 = Card.create({
          name:               alt_name,
          extension_set_id:   extension_set_id,
          detailed_type:      alt_detailed_type,
          rarity:             alt_rarity,
          text:               alt_retrieve_text,
          cmc:                alt_cmc,
          mana_cost:          alt_mana_cost,
          image:              image(alt_gatherer_id, true),
          artist_name:        alt_artist_name,
          number_in_set:      alt_number_in_set,
          gatherer_link:      card_url,
          gatherer_id:        alt_gatherer_id,
          flavor_text:        alt_flavor_text,
          power_str:          alt_power_str,
          defense_str:        alt_defense_str,
          color_indicator:    alt_color_indicator,
          loyalty:            alt_loyalty,
        })
        Alternative.create(card_id: @card_1.id, alternative_card_id: @card_2.id)
        puts "ALT CARD CREATE : #{@card_1.name} // #{@card_2.name} imported"
      end
      if (gatherer_url = GathererCardUrl.where(url: card_url, extension_set_id: extension_set_id).first)
        gatherer_url.destroy
      end
    rescue
      if (@card_1)
        @card_1.destroy
      end
      puts "#{card_url} failed"
      File.open(URI.join("#{Rails.root}/#{link_gatherer_id(card_url)}.html").to_s, 'w+') do |file|
        file.write @doc.to_html.gsub('../..', 'http://gatherer.wizards.com').gsub('href="/Styles', 'href="http://gatherer.wizards.com/Styles')
      end
      if GathererCardUrl.where(url: card_url, extension_set_id: extension_set_id).none?
        GathererCardUrl.create(url: card_url, extension_set_id: extension_set_id)
      end
    end
  end

  def link_gatherer_id(card_url)
    card_url.match(/multiverseid=(\d+)/)[1]
  end

  def gatherer_id
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_1_selector}_cardImage").first.attribute('src').value.match(/multiverseid=(\d+)/)[1]
  end

  def alt_gatherer_id
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_2_selector}_cardImage").first.attribute('src').value.match(/multiverseid=(\d+)/)[1]
  end


  def name
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_1_selector}_nameRow .value").first.text.squish
  end

  def detailed_type
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_1_selector}_typeRow .value").first.text.squish
  end

  def rarity
    rarity_text = @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_1_selector}_rarityRow .value").first.text.squish.downcase
    case rarity_text
    when 'mythic rare'
      :mythic
    when 'basic land'
      :common
    when 'special'
      :mythic
    else
      rarity_text.to_sym
    end
  end

  def retrieve_text
    if @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_1_selector}_textRow .value").first
      result = build_text_from(@doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_1_selector}_textRow .value").first, '')
    else
      nil
    end
  end

  def cmc
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_1_selector}_cmcRow .value").first&.text&.squish
  end

  def mana_cost
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_1_selector}_manaRow .value img").collect do |cost_img|
      retrieve_color(cost_img.attribute('alt').value)
    end.join
  end

  def image(id, rotate)
    open("http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=#{id}&type=card#{rotate ? '&options=rotate180' : ''}")
  end

  def artist_name
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_1_selector}_artistRow .value").first&.text&.squish
  end

  def number_in_set
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_1_selector}_numberRow .value").first&.text&.squish&.to_i
  end

  def flavor_text
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_1_selector}_FlavorText .value").first&.text&.squish
  end

  def power_str
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_1_selector}_ptRow .value").first&.text&.squish&.split('/')&.first&.squish
  end

  def defense_str
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_1_selector}_ptRow .value").first&.text&.squish&.split('/')&.last&.squish
  end

  def color_indicator
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_1_selector}_colorIndicatorRow .value").first&.text&.squish
  end

  def loyalty
    if (power_thougtness = @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_1_selector}_ptRow .value").first&.text&.squish)
      power_thougtness.include?('/') ? nil : power_thougtness
    end
  end

  # ALT CARD

  def alt_name
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_2_selector}_nameRow .value").first.text.squish
  end

  def alt_detailed_type
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_2_selector}_typeRow .value").first.text.squish
  end

  def alt_rarity
    rarity_text = @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_2_selector}_rarityRow .value").first.text.squish.downcase
    case rarity_text
    when 'mythic rare'
      :mythic
    when 'basic land'
      :common
    when 'special'
      :mythic
    else
      rarity_text.to_sym
    end
  end

  def alt_retrieve_text
    if @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_2_selector}_textRow .value").first
      result = build_text_from(@doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_2_selector}_textRow .value").first, '')
    else
      nil
    end
  end

  def alt_cmc
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_2_selector}_cmcRow .value").first&.text&.squish
  end

  def alt_mana_cost
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_2_selector}_manaRow .value img").collect do |cost_img|
      retrieve_color(cost_img.attribute('alt').value)
    end.join
  end

  def alt_artist_name
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_2_selector}_artistRow .value").first&.text&.squish
  end

  def alt_number_in_set
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_2_selector}_numberRow .value").first&.text&.squish&.to_i
  end

  def alt_flavor_text
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_2_selector}_FlavorText .value").first&.text&.squish
  end

  def alt_power_str
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_2_selector}_ptRow .value").first&.text&.squish&.split('/')&.first&.squish
  end

  def alt_defense_str
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_2_selector}_ptRow .value").first&.text&.squish&.split('/')&.last&.squish
  end

  def alt_color_indicator
    @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_2_selector}_colorIndicatorRow .value").first&.text&.squish
  end

  def alt_loyalty
    if (power_thougtness = @doc.css("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_#{@card_2_selector}_ptRow .value").first&.text&.squish)
      power_thougtness.include?('/') ? nil : power_thougtness
    end
  end

  # COMMUNS

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

  def retrieve_symbol(value)
    "{#{retrieve_color(value).downcase}}"
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
    else
      value
    end
  end
end
