class CardDecorator < Draper::Decorator
  include ApplicationHelper

  decorates_finders
  delegate_all

  def title(show_rarity: false, show_extension: false)
    title = if show_rarity
              "#{h.content_tag(:span, "#{rarity[0].upcase}", class: "rarity-#{rarity}")} #{(card.name_fr || card.name || '')}".html_safe
            else
              card.name_fr || card.name || ''
            end

    (show_extension ? "#{title}, #{card.extension_set.name}" : title).html_safe # show also extension symbole
  end

  def visual
    image_fr&.url || image&.url || ''
  end

  def name_with_set
    "#{name_fr} - #{extension.set.name}"
  end
end
