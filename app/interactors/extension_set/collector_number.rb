class ExtensionSet::CollectorNumber
  include Interactor

  # WORK ON COLLECTOR NUMBER
  # https://mtg.gamepedia.com/Collector_number
  def call
    def count_cards_n(i)
      return 0 unless i.positive?
      j = 0
      (1..i).each do |n|
        j += n
      end
      j
    end

    ensure_cards_num_set_id = []

    ExtensionSet.all.each do |set|
      ensure_cards_num_set_id << set.id if set.cards.collect(&:number_in_set).compact.sum != count_cards_n(set.cards.count)
    end

    number_set_ids = []
    total_card_issue_set_ids = []
    ExtensionSet.all.each do |set|
      next if set.cards.none?

      puts set.name
      n = 0
      set.cards.order(number_in_set: :asc).each do |card|
        n += 1
        if card.number_in_set != n
          number_set_ids << set.id
          break
        end
      end
      if set.cards.order(number_in_set: :asc).last.number_in_set != set.card_count && !number_in_set_issue_set_ids.include?(set.id)
        number_in_set_issue_set_ids << set.id
      end
      if !number_in_set_issue_set_ids.include?(set.id)
        puts "#{set.name} ok"
      end
    end

    extensionset_with_no_number_ids = []
    ExtensionSet.all.each do |set|
      extensionset_with_no_number_ids << set.id if set.cards.where.not(number_in_set: nil).none?
    end
  end
end
