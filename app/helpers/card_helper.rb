module CardHelper
  def card_scryfall_image_url(card)
    api_url = "https://api.scryfall.com/cards/#{card.json_data['identifiers']['scryfallId']}"
    # api_url = "https://api.scryfall.com/cards/#{card.json_set.code.downcase}/#{card.number}"
    client = HTTPClient.new(default_header: { 'Accept-Language' => 'en-US' }).get(api_url)

    json = JSON.parse(client.body)
    if (url = json.dig('image_uris', 'normal'))
      url
    else
      asset_path('card-background.jpg')
    end
  end

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
