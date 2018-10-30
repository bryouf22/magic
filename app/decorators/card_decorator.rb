class CardDecorator < Draper::Decorator
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

  def title(show_rarity: false)
    if show_rarity
      "#{h.content_tag(:span, "#{rarity[0].upcase}", class: "rarity-#{rarity}")} #{(card.name_fr || card.name || '')}".html_safe
    else
      card.name_fr || card.name || ''
    end
  end

  def visual
    image_fr&.url || image&.url || ''
  end

  def rule_text
    text_fr || text || ''
  end

  def flavor
    flavor_text_fr || flavor_text || ''
  end

  def name_with_set
    "#{name_fr} - #{extension.set.name}"
  end

  private

  def mana_img_path(c)
    if c.to_i.to_s == c
      "mana/#{c}.jpg"
    else
      case c
      when 'u'
        'mana/blue.jpg'
      when 'b'
        'mana/black.jpg'
      when 'r'
        'mana/red.jpg'
      when 'g'
        'mana/green.gif'
      when 'w'
        'mana/white.gif'
      else
        "mana/#{c}.png"
      end
    end
  end
end
