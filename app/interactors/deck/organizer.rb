class Deck::Organizer
  include Interactor

  def call
    user = User.find(context.user_id)

    basics = {}
    others = {}

    user.decks.each do |deck|
      deck.card_decks.each do |card_deck|
        count = card_deck.occurences_in_sideboard + card_deck.occurences_in_main_deck
        card_name = card_deck.card.name
        if card_deck.card.basic_land?
          if basics[card_name].present?
            already_present = basics[card_name]
            basics[card_name] = already_present + count
          else
            basics[card_name] = count
          end
        elsif others[card_name].present?
          others[card_name][:count] = count if count > others[card_name][:count]
          others[card_name][:decks] << "#{deck.name} (x#{count})"
        else
          others[card_name] = {
            count: count,
            decks: ["#{deck.name} (x#{count})"]
          }
        end
      end
    end

    result = {}
    others.each do |card_name, data|
      deck_name = ''

      if data[:decks].one?
        deck_name = data[:decks].first.split(' (x').first
        count     = data[:decks].first.split(' ').last.match(/\(x(\d+)\)$/)[1]
      else
        deck_names = []

        data[:decks].each do |deck_name_with_count|
          deck_name = deck_name_with_count.split(' (x').first
          count     = deck_name_with_count.split(' ').last.match(/\(x(\d+)\)$/)[1]

          deck_names << deck_name
        end
        deck_name = deck_names.join(' / ')
      end

      result[deck_name] = [] if result[deck_name].nil?
      result[deck_name] << "#{card_name} (x#{data[:count]})"
    end
  end
end
