module CardHelper
  def image_show(card)
    if card.has_alternative?
      case card.alternative_type
      when 'recto_verso'
        content_tag(
          :div,
          image_tag(card.image.url, class: 'recto') + image_tag(card.alternative_card.image.url, class: 'verso'),
          class: 'image-wrapper'
        )
      when 'double_card'
        image_tag(card.image.url, class: 'rotate')
      when 'flip_card'
        image_tag(card.image.url, class: 'flip')
      when 'adventure'
        image_tag(card.image.url)
      end
    else
      image_tag(card.image.url)
    end
  end
end
