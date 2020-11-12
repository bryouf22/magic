module ApplicationHelper
  include Pagy::Frontend

  TYPE_ORDER = {
    creature: 1,
    creature_artifact: 2,
    planeswalker: 3,
    instant: 4,
    sorcery: 5,
    enchantement: 6,
    tribal: 7,
    artifact: 8,
    land: 9,
    other: 10
  }

  def mana_for_list(list_name)
    mana_icons = case list_name.to_s.downcase
                 when 'green'
                   Color::SYMBOL_FILE_MAPPING[:g]
                 when 'red'
                   Color::SYMBOL_FILE_MAPPING[:r]
                 when 'blue'
                   Color::SYMBOL_FILE_MAPPING[:u]
                 when 'black'
                   Color::SYMBOL_FILE_MAPPING[:b]
                 when 'white'
                   Color::SYMBOL_FILE_MAPPING[:w]
                 when 'colorless'
                   return nil
                 when 'artefact'
                   return nil
                 when 'gold'
                   [Color::SYMBOL_FILE_MAPPING[:g], Color::SYMBOL_FILE_MAPPING[:u]]
                 when 'double_card'
                   return nil
                 when 'hybrid'
                   [Color::SYMBOL_FILE_MAPPING[:j], Color::SYMBOL_FILE_MAPPING[:l]]
                 when 'land'
                   return nil
                 else
                   return nil
                 end
    Array.wrap(mana_icons).map(&:to_s).map { |c_ico| "ms-#{c_ico}" }
  end

  def pretty_checkbox(name, options = {})
    # TODO : recup args dans un hash
    # puis faire un delete de pretty class/label et passer le reste au helper checkbox
    content_tag(:div,
                check_box_tag(name, options[:value], options[:checked], id: options[:id], class: options[:class].presence) +
                content_tag(:div, content_tag(:label, options[:label]), class: "state p-#{options[:pretty_class]}"),
                class: 'pretty p-default')
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

  def sort_deck_cards(cards)
    { 'Creatures' => cards.creatures.decorate, 'Others' => cards.others.decorate, 'Lands' => cards.land.decorate }.reject { |_k, v| v.none? }
  end

  def fr_ordinalize(number)
    if number == 1
      "#{number}#{I18n.t('ordinalizer')[0]}"
    else
      "#{number}#{I18n.t('ordinalizer')[1]}"
    end
  end

  def sort_cards_by_type(cards)
    cards.sort do |card, another|
      if TYPE_ORDER[card.card_type.to_sym] < TYPE_ORDER[another.card_type.to_sym]
        -1
      elsif TYPE_ORDER[card.card_type.to_sym] > TYPE_ORDER[another.card_type.to_sym]
        1
      else
        card.name <=> another.name
      end
    end
  end

  private

  def show_deck_color(deck)
    result = ''
    deck.colors.sort.each do |color|
      result << content_tag(:i, '', class: "ms ms-#{Color::DECK_COLOR_MAPPING[color.to_sym]} ms-cost")
    end
    return content_tag(:i, '', class: 'ms ms-c ms-cost').html_safe if result.blank?

    result.html_safe
  end

  # TODO : GERER LES DEMIS MANA (VOIR LITTLE GIRL)
  def show_card_mana_cost(card)
    result = ''

    card.mana_cost.split(/(Snow|\d+|\D)/).reject { |c| c.blank? }.each do |mana_cost|
      result << if mana_cost == mana_cost.to_i.to_s
                  content_tag(:i, '', class: "ms ms-#{mana_cost} ms-cost")
                else
                  content_tag(:i, '', class: "ms ms-#{Color::SYMBOL_FILE_MAPPING[mana_cost.to_sym]} ms-cost")
                end
    end
    result.html_safe
  end
end
