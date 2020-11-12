class CardDecorator < Draper::Decorator
  include ApplicationHelper

  decorates_finders
  delegate_all

  def title(show_rarity: false, show_extension: false)
    card_name = card.name || ''
    title = if show_rarity
              "#{h.content_tag(:i, '', class: "ss ss-#{extension_set.code&.downcase} ss-#{card.rarity} ss-grad")}#{card_name}".html_safe
            else
              card_name
            end

    (show_extension ? "#{title}, #{card.extension_set.name}" : title).html_safe
  end

  def set_icon
    h.content_tag(
      :i,
      '',
      class: "ss ss-#{extension_set.code&.downcase} ss-#{card.rarity} ss-grad",
      title: extension_set.name, data: { toggle: :tooltip, placement: :bottom }
    )
  end

  def set_and_reprint_icons
    (reprint_cards.decorate.map(&:set_icon) << set_icon).uniq[0..9].join.html_safe
  end

  def name_with_extension
    "#{name} - #{extension_set.name}"
  end
end
