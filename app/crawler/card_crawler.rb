class CardCrawler < BaseCrawler
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  BASE_SELECTOR = 'ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_'

  def initialize(url, set_id = nil)
    binding.pry
    puts "------------"
    puts url
    puts "------------"
    if !set_id.present?
      html = html_from_url(url)
      @data = retrieve_card_attributes(html, url)
      @data.merge!(set_name: retrieve_set_name)
    else
      begin
        html    = html_from_url(url)
        success = if double_card?(html)
                    import_double_card(html, set_id, url)
                  else
                    import_simple_card(html, set_id, url)
                  end

        if success && (gatherer_url = GathererCardUrl.where(url: url, extension_set_id: set_id)&.first)
          gatherer_url.destroy
        elsif !success && GathererCardUrl.where(url: url, extension_set_id: set_id).none?
          GathererCardUrl.create(url: url, extension_set_id: set_id)
        end
      rescue
        GathererCardUrl.create(url: url, extension_set_id: set_id) if GathererCardUrl.where(url: url, extension_set_id: set_id).none?
      end
    end
  end

  def retrieve_data(url, rotate = false)
    url = "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=#{gatherer_id(url)}&type=card"
    url += '&options=rotate180' if rotate
    @data.merge(image_url: url)
  end

  def retrieve_set_name
    @doc.css("##{BASE_SELECTOR}currentSetSymbol a:last-of-type").first.text.squish
  end

  def double_card?(html)
    if html.css("##{BASE_SELECTOR}cardComponent0 ##{BASE_SELECTOR}ctl01_componentWrapper").present?
      true
    elsif html.css("##{BASE_SELECTOR}cardComponent0 ##{BASE_SELECTOR}ctl02_componentWrapper").present?
      true
    elsif html.css("##{BASE_SELECTOR}cardComponent0 ##{BASE_SELECTOR}ctl03_componentWrapper").present?
      true
    else
      false
    end
  end

  def import_other_basic_lands(url, html, set_id)
    # TODO
  end

  def import_simple_card(html, set_id, url)
    card_attributes = retrieve_card_attributes(html, url).merge(extension_set_id: set_id)
    card = Card.create(card_attributes)
    if card.valid?
      import_other_basic_lands(url, html, set_id) if card.basic_land?
      true
    elsif ExtensionSet.find(240).cards.where(name: card.name).any?
      true
    else
      false
    end
  end

  def import_double_card(html, set_id, url)
    selectors = get_selectors(html)
    card_one = create_first_card(html, set_id, selectors, url)
    card_two = create_second_card(html, set_id, selectors, url)

    card_one.destroy if card_one.valid? && !card_two.valid?

    if card_one.valid? && card_two.valid?
      card_one.update(is_double_card: true, is_double_part: false) # TODO : ALTERNATIVE_TYPE SEE MODEL ALTERNATIVE FOR MAPPING
      Alternative.create(card_id: card_one.id, alternative_card_id: card_two.id, alternative_type: alternative_types(ExtensionSet.find(217).name))
      card_two.update(gatherer_id: card_one.gatherer_id, is_double_part: true)
      true
    else
      false
    end
  end

  def create_first_card(html, set_id, selectors, url)
    card_attributes = first_card_attribute_of_double(html, url, selectors.first)
    Card.create(card_attributes.merge(extension_set_id: set_id))
  end

  def create_second_card(html, set_id, selectors, url)
    card_attributes = second_card_attribute_of_double(html, url, selectors.last, set_id)
    Card.create(card_attributes.merge(extension_set_id: set_id))
  end

  def first_card_attribute_of_double(html, url, selector)
    @doc = html
    g_id = gatherer_id(url, selector)
    {
      name: name_en(selector),
      detailed_type: detailed_type(selector),
      rarity: rarity(selector),
      text: retrieve_text(selector),
      cmc: cmc(selector),
      mana_cost: mana_cost(selector),
      image: image(g_id),
      artist_name: artist_name(selector),
      number_in_set: number_in_set(selector),
      gatherer_link: url,
      gatherer_id: g_id,
      flavor_text: flavor_text(selector),
      power_str: power_str(selector),
      defense_str: defense_str(selector),
      color_indicator: color_indicator(selector),
      loyalty: loyalty(selector)
    }
  end

  def second_card_attribute_of_double(html, url, selector, set_id)
    @doc = html
    g_id = gatherer_id(url, selector)
    {
      name: name_en(selector),
      detailed_type: detailed_type(selector),
      rarity: rarity(selector),
      text: retrieve_text(selector),
      cmc: cmc(selector),
      mana_cost: mana_cost(selector),
      image: image(g_id, rotate_double_visual?(set_id)),
      artist_name: artist_name(selector),
      number_in_set: number_in_set(selector),
      gatherer_id: "XXX",
      gatherer_link: url,
      flavor_text: flavor_text(selector),
      power_str: power_str(selector),
      defense_str: defense_str(selector),
      color_indicator: color_indicator(selector),
      loyalty: loyalty(selector)
    }
  end

  def retrieve_card_attributes(html, url)
    @doc = html
    g_id = gatherer_id(url)
    {
      name: name_en,
      detailed_type: detailed_type,
      rarity: rarity,
      text: retrieve_text,
      cmc: cmc,
      mana_cost: mana_cost,
      image: image(g_id),
      artist_name: artist_name,
      number_in_set: number_in_set,
      gatherer_link: url,
      gatherer_id: g_id,
      flavor_text: flavor_text,
      power_str: power_str,
      defense_str: defense_str,
      color_indicator: color_indicator,
      loyalty: loyalty
    }
  end

  def gatherer_id(url, selector = '')
    return @doc.css("##{BASE_SELECTOR}#{selector}cardImage").first.attribute('src').value.match(/multiverseid=(\d+)/)[1] if selector.present?

    url.match(/multiverseid=(\d+)/)[1]
  end

  def get_selectors(html)
    if html.css("##{BASE_SELECTOR}cardComponent0 ##{BASE_SELECTOR}ctl01_componentWrapper").present?
      ['ctl01_', 'ctl02_']
    elsif html.css("##{BASE_SELECTOR}cardComponent0 ##{BASE_SELECTOR}ctl02_componentWrapper").present?
      ['ctl02_', 'ctl03_']
    elsif html.css("##{BASE_SELECTOR}cardComponent0 ##{BASE_SELECTOR}ctl03_componentWrapper").present?
      ['ctl03_', 'ctl04_']
    end
  end

  def name_en(selector = '')
    @doc.css("##{BASE_SELECTOR}#{selector}nameRow .value").first.text.squish
  end

  def detailed_type(selector = '')
    @doc.css("##{BASE_SELECTOR}#{selector}typeRow .value").first.text.squish
  end

  def rarity(selector = '')
    rarity_text = @doc.css("##{BASE_SELECTOR}#{selector}rarityRow .value").first.text.squish.downcase
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

  def retrieve_text(selector = '')
    return build_text_from(@doc.css("##{BASE_SELECTOR}#{selector}textRow .value").first, '') if @doc.css("##{BASE_SELECTOR}#{selector}textRow .value").first
  end

  def cmc(selector = '')
    @doc.css("##{BASE_SELECTOR}#{selector}cmcRow .value").first&.text&.squish
  end

  def mana_cost(selector = '')
    @doc.css("##{BASE_SELECTOR}#{selector}manaRow .value img").collect do |cost_img|
      retrieve_color(cost_img.attribute('alt').value)
    end.join
  end

  def artist_name(selector = '')
    @doc.css("##{BASE_SELECTOR}#{selector}artistRow .value").first&.text&.squish
  end

  def number_in_set(selector = '')
    @doc.css("##{BASE_SELECTOR}#{selector}numberRow .value").first&.text&.squish&.to_i
  end

  def flavor_text(selector = '')
    @doc.css("##{BASE_SELECTOR}#{selector}FlavorText.value").first&.text&.squish
  end

  def power_str(selector = '')
    if (power_def = @doc.css("##{BASE_SELECTOR}#{selector}ptRow .value").first&.text&.squish)
      power_def.include?('/') ? power_def.split('/')&.first&.squish : nil
    else
      nil
    end
  end

  def defense_str(selector = '')
    if (power_def = @doc.css("##{BASE_SELECTOR}#{selector}ptRow .value").first&.text&.squish)
      power_def.include?('/') ? power_def.split('/')&.last&.squish : nil
    else
      nil
    end
  end

  def color_indicator(selector = '')
    @doc.css("##{BASE_SELECTOR}#{selector}colorIndicatorRow .value").first&.text&.squish
  end

  def loyalty(selector = '')
    if (power_thougtness = @doc.css("##{BASE_SELECTOR}#{selector}ptRow .value").first&.text&.squish)
      power_thougtness.include?('/') ? nil : power_thougtness
    end
  end

  def image(id, rotate = false)
    url = "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=#{id}&type=card"
    url += '&options=rotate180' if rotate
    open(url)
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
    when 'White or Blue'
      'a'
    when 'Blue or Black'
      'c'
    when 'Black or Red'
      'd'
    when 'Red or Green'
      'e'
    when 'Green or White'
      'f'
    when 'White or Black'
      'h'
    when 'Blue or Red'
      'i'
    when 'Black or Green'
      'j'
    when 'Red or White'
      'k'
    when 'Green or Blue'
      'l'
    when 'Two or White'
      'm'
    when 'Two or Blue'
      'n'
    when 'Two or Black'
      'o'
    when 'Two or Red'
      'p'
    when 'Two or Green'
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
end
