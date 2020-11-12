module ChartHelper
  CODE_COLORS = {
    only_white: '#fffbc7',
    only_green: '#117100',
    only_blue: '#0071e9',
    only_red: '#b11919',
    only_black: '#2c2c2c',
    colorless: '#d9d9d9',
    gold: '#dccc00',
    lands: '#5f5c5e'
  }

  def converted_mana_cost_graph(deck)
    return ''
    {} # TODO

    bar_chart Shirt.group(:size).sum(:price)
  end

  def color_graph(deck)
    result = {}
    color  = []
    { only_white: 'Blanche', only_green: 'Verte', only_red: 'Rouge', only_blue: 'Bleue', only_black: 'Noire', gold: 'Multicolore', colorless: 'Incolore' }.each do |color_scope, designation|
      color_cards = deck.cards.__send__(color_scope).where.not(card_type: :land)
      next unless color_cards.count.positive?

      result[designation] = deck.card_decks.where(card_id: color_cards.ids).sum { |cd| cd.occurences_in_main_deck + cd.occurences_in_sideboard }
      result[designation] = deck.card_decks.where(card_id: color_cards.ids).sum(&:occurences_in_main_deck)
      color << CODE_COLORS[color_scope]
    end
    land_ids = deck.cards.where(card_type: :land).ids
    if land_ids.any?
      # result['Terrain'] = deck.card_decks.where(card_id: land_ids).sum { |cd| cd.occurences_in_main_deck + cd.occurences_in_sideboard }
      result['Terrain'] = deck.card_decks.where(card_id: land_ids).sum(&:occurences_in_main_deck)
      color << CODE_COLORS[:lands]
    end
    pie_chart(result, colors: color)
  end
end
