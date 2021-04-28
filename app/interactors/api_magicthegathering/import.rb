require 'fileutils'
require 'openssl'

class ApiMagicthegathering::Import
  include Interactor

  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  BASE_URL = "https://api.magicthegathering.io/v1/"
  BOUSE_OUT = "#{Rails.application.root}/json_sources"

  def call
    FileUtils.rm_rf(BOUSE_OUT)
    FileUtils.mkdir_p(BOUSE_OUT)

    retrieve_jsons
    import_sets
    import_cards
  end

  private

  def retrieve_jsons
    ['sets', 'cards'].each do |entry|
      page = 0
      can_continue = true

      while can_continue
        sleep (0..10).to_a.sample

        page += 1

        url = "#{BASE_URL}#{entry}?page=#{page}"
        client = HTTPClient.new(default_header: { 'Accept-Language' => 'en-US' }).get(url)

        json = JSON.parse(client.body)
        if json[entry].present?
          File.open("#{BOUSE_OUT}/#{entry}_#{page}.json", 'w+') do |file|
            file.write json.to_json
          end
        else
          can_continue = false
        end
      end
    end
  end

  def import_sets
    Dir["#{BOUSE_OUT}/sets_*"].each do |file_path|
      content = JSON.parse(File.open(file_path).read)
      content['sets'].each do |set|
        import_set(set)
      end
    end
  end

  def import_set(set)
    return if SetData.where(name: set['name']).any?

    new_set = SetData.new
    set.each do |key, value|
      card_attr = key.underscore
      card_attr = 'set_type' if card_attr == 'type'

      if value.is_a?(Array) && value.first.is_a?(Array) && value.first == ["rare","mythic rare"]
        value = value.flatten
        value.delete('rare')
        value.delete('mythic rare')
        value.insert(0, 'rare/mythic rare')
      end
      new_set.send("#{card_attr}=", value)
    end
    new_set.save
  end

  def import_cards
    Dir["#{BOUSE_OUT}/cards_*"].each do |file_path|
      content = JSON.parse(File.open(file_path).read)
      content['cards'].each do |card|
        import_card(card)
      end
    end
  end

  def import_card(card)
    card_data = if CardData.where(api_id: card['id']).none?
                  new_card = CardData.new

                  card.each do |key, value|
                    next if key.in? ['foreignNames', 'legalities', 'rulings']

                    card_attr = key.underscore
                    card_attr = 'api_id'    if card_attr == 'id'
                    card_attr = 'card_type' if card_attr == 'type'

                    new_card.send("#{card_attr}=", value)
                  end
                  new_card.set_data_id = SetData.where(code: card['set']).first.id
                  new_card.save
                  new_card
                else
                  CardData.where(api_id: card['id']).first
                end

    if card['foreignNames'].present?
      card['foreignNames'].each do |foreignname|
        next if card_data.foreign_names.where(name: foreignname['name']).any?

        cd_fn = CardDatas::ForeignName.create(card_data_id: card_data.id)
        foreignname.each do |key, value|
          model_attr = key.underscore
          model_attr = 'foreign_name_type' if model_attr == 'type'
          cd_fn.send("#{model_attr}=", value)
        end
        cd_fn.save
      end
    end

    if card['legalities'].present?
      card['legalities'].each do |legality|
        next if card_data.legalities.where(format: legality['format'], legality: legality['legality']).any?

        cd_l = CardDatas::Legality.create(card_data_id: card_data.id)
        legality.each do |key, value|
          cd_l.send("#{key.underscore}=", value)
        end
        cd_l.save
      end
    end

    if card['rulings'].present?
      card['rulings'].each do |rulling|
        next if card_data.rulllings.where(text: rulling['text']).any?

        cd_r = CardDatas::Rulling.create(card_data_id: card_data.id)
        rulling.each do |key, value|
          cd_r.send("#{key.underscore}=", value)
        end
        cd_r.save
      end
    end
  end
end
