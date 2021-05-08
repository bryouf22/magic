require 'fileutils'
require 'openssl'
require 'zip'

class MtgJson::Script
  include Interactor

  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  def call
  end

  private

  # find json_token -type f | wc -l
  def json_sets_without_image
    ids = []
    JsonSet.all.each do |set|
      if set.json_cards.any?
        if File.exist?("/home/deploy/magic/shared/public/#{set.json_cards.first.image_url}")
          next
        else
          ids << set.id
        end
      elsif set.json_tokens.any?
        if File.exist?("/home/deploy/magic/shared/public/#{set.json_tokens.first.image_url}")
          next
        else
          ids << set.id
        end
      end
      ids
    end
  end

  def import_missings_cards_images
    JsonCard.limit(101).order(id: :desc).each do |card|
      unless File.exist?("/home/deploy/magic/shared/public/#{card.image_url}")
        import_image(card)
      end
    end
  end

  def import_missings_token_images
    JsonToken.all.order(id: :desc).each do |token|
      unless File.exist?("/home/deploy/magic/shared/public/#{token.image_url}")
        import_image(token)
      end
    end
  end

  def import_image(model)
    begin
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
    rescue
    end
  end
end
