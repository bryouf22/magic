class CardDecorator < Draper::Decorator
  include ApplicationHelper
  decorates_finders
  delegate_all

  def cost
    return '' unless mana_cost
    result = ''
    mana_cost.each_char do |c|
      result << h.image_tag(mana_img_path(c))
    end
    result.html_safe
  end

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

  def rule_text
    result = text_fr || text || ''
    result.scan(/\{([^\}]+)\}/im).each do |symbole|
      img = h.image_url("card_symboles/#{symbole.first}.png")
      result.sub!("{#{symbole.first}}", h.content_tag(:span, '', style: "background-image: url('#{img}')", class: 'text-symbole'))
    end
    # result.gsub!(/(\n)[^<]/m, "<br/>")
    result.html_safe
  end

  def flavor
    flavor_text_fr || flavor_text || ''
  end

  def name_with_set
    "#{name_fr} - #{extension.set.name}"
  end
end
