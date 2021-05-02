require 'fileutils'
require 'openssl'
require 'zip'

class MtgJson::ImportImages
  include Interactor

  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  def call
    if context.json_card.present?
      return import_image(context.json_card)
    end
    if context.json_set.present?
      context.json_set.json_cards.where(image: nil).find_each do |card|
        import_image(card)
        sleep((4..12).to_a.sample)
      end
      context.json_set.json_tokens.where(image: nil).find_each do |token|
        import_image(token)
        sleep((4..12).to_a.sample)
      end
    else
      JsonCard.where(image: nil).find_each do |card|
        import_image(card)
      end
      JsonToken.where(image: nil).find_each do |token|
        import_image(token)
      end
    end
  end

  private

  def import_image(model)
    api_url = "https://api.scryfall.com/cards/#{model.json_data['identifiers']['scryfallId']}"
    client = HTTPClient.new(default_header: { 'Accept-Language' => 'en-US' }).get(api_url)

    json = JSON.parse(client.body)
    if (url = json.dig('image_uris', 'normal'))
      model.image = open(url)
      model.save
    elsif model.json_data['faceName'].present? && (url = json["card_faces"].find { |cf| cf['name'] == model.json_data['faceName'] }.dig('image_uris', 'normal'))
      model.image = open(url)
      model.save
    end
  end
end
