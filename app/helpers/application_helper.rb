module ApplicationHelper
  include Pagy::Frontend

  def pretty_checkbox(name, options = {})
    # TODO : recup args dans un hash
    # puis faire un delete de pretty class/label et passer le reste au helper checkbox
    content_tag(:div,
      check_box_tag(name, options[:value], options[:checked], id: options[:id], class: options[:class].presence) +
      content_tag(:div, content_tag(:label, options[:label]), class: "state p-#{options[:pretty_class]}"),
      class: "pretty p-default")
  end

  def show_mana_cost(object)
    case object.class.name
    when 'Deck'
      show_deck_color(object)
    when 'CardDecorator'
      show_card_mana_cost(object)
    when 'Card'
      show_card_mana_cost(object)
    end
  end

  def mana_img_path(c)
    if c.to_s.to_i.to_s == c
      "card_symboles/#{c}.jfif"
    else
      "card_symboles/#{Color::SYMBOL_FILE_MAPPING[c.to_sym]}.jfif"
    end
  end

  def sort_deck_cards(cards)
    { 'Créatures' => cards.creatures.decorate, 'Autres' => cards.others.decorate, 'Terrains' => cards.land.decorate }.reject { |k, v| v.none? }
  end

  def fr_ordinalize(number)
    if number == 1
      "#{number}#{I18n.t('ordinalizer')[0]}"
    else
      "#{number}#{I18n.t('ordinalizer')[1]}"
    end
  end

  private

  def show_deck_color(deck)
    result = ""
    deck.colors.each do |color|
      result << content_tag(:i, '', class: "ms ms-#{Color::DECK_COLOR_MAPPING[color.to_sym]} ms-cost")
    end
    return content_tag(:i, '', class: "ms ms-c ms-cost").html_safe if result.blank?
    result.html_safe
  end

  # todo : gérer les demis mana (voir little girl)
  def show_card_mana_cost(card)
    result = ''
    card.mana_cost.split(/(Snow|\d+|\D)/).reject { |c| c.blank? }.each do |mana_cost|
      if mana_cost == mana_cost.to_i.to_s
        result << content_tag(:i, '', class: "ms ms-#{mana_cost} ms-cost")
      else
        result << content_tag(:i, '', class: "ms ms-#{Color::SYMBOL_FILE_MAPPING[mana_cost.to_sym]} ms-cost")
      end
    end
    result.html_safe
  end
end
