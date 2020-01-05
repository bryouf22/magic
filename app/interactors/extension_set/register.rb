class ExtensionSet::Register
  include Interactor

  def call
    if ExtensionSet.where(release_date: nil).any?
      context.fail!(error: "Veuillez renseigner toutes les dates de sortie !")
    else
      Card.all.find_each do |card|
        if card.reprint_cards.count.positive?
          is_first_edition = true
          card.reprint_cards.each do |reprint|
            if reprint.extension_set.release_date < card.extension_set.release_date
              is_first_edition = false
              break
            end
          end
          card.update(first_edition: is_first_edition) unless card.first_edition == is_first_edition
        else
          card.update(first_edition: true) unless card.first_edition == true
        end
      end

      # TODO, dont count double cards in totals
      ExtensionSet.all.each do |set|
        set.update(
          reprint_count:  set.cards.where(first_edition: false).count,
          card_count:     set.cards.count,
          new_card_count: (set.cards.count - set.cards.where(first_edition: false).count)
        )
      end
    end
  end
end
