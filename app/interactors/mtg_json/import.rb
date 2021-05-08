require 'fileutils'
require 'openssl'
require 'zip'

class MtgJson::Import
  include Interactor

  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  BASE_URL = "https://mtgjson.com/api/v5/AllPrintings.json.zip"
  BOUSE_OUT = "#{Rails.application.root}/json_sources"

  def call
    FileUtils.rm_rf(BOUSE_OUT)
    FileUtils.mkdir_p(BOUSE_OUT)
    retrieve_json

    if context.recent
      limit_date = Date.current - 10.days
      import_sets(limit_date)
      import_cards(limit_date)
      import_tokens(limit_date)
    else
      import_sets
      import_cards
      import_tokens
    end
  end

  private

  def retrieve_json
    open("#{BOUSE_OUT}/AllPrintings.json.zip", 'wb') do |file|
      file << open(BASE_URL).read
    end

    Zip::File.open("#{BOUSE_OUT}/AllPrintings.json.zip") do |zip_file|
      zip_file.each do |f|
        fpath = File.join(BOUSE_OUT, f.name)
        FileUtils.mkdir_p(File.dirname(fpath))
        zip_file.extract(f, fpath) unless File.exist?(fpath)
      end
    end
  end

  def json_content
    @content ||= JSON.parse(File.open("#{BOUSE_OUT}/AllPrintings.json").read)
  end

  def import_sets(date = nil)
    json_content['data'].each do |key, value|
      next if date && value['releaseDate'].to_date < date

      set = JsonSet.where(code: key).first || JsonSet.new
      set.code = key            if set.new_record?
      set.name = value['name']  if set.new_record?

      set.json_data = value.reject { |k| k.in?(['cards', 'tokens', 'booster']) }
      set.set_type = set.json_data['type']
      set.release_date = set.json_data['releaseDate']
      set.total_set_size = set.json_data['totalSetSize']
      set.save
    end
  end

  def import_cards(date = nil)
    json_content['data'].keys.each do |key|
      if (set = JsonSet.where(code: key).first)
        next if date && json_content['data'][key]['releaseDate'].to_date < date

        json_content['data'][key]['cards'].each do |card|
          next if JsonCard.where(uuid: card['uuid']).any?

          json_card = JsonCard.new
          json_card.uuid = card['uuid']
          json_card.name = card['name']
          json_card.number = card['number']
          json_card.json_set_id = set.id
          json_card.json_data = card
          json_card.save
        end
      end
    end
  end

  def import_tokens(date = nil)
    json_content['data'].keys.each do |key|
      if (set = JsonSet.where(code: key).first)
        json_content['data'][key]['tokens'].each do |token|
          next if JsonToken.where(uuid: token['uuid']).any?

          json_token = JsonToken.new
          json_token.uuid = token['uuid']
          json_token.name = token['name']
          json_token.json_set_id = set.id
          json_token.json_data = token
          json_token.save
        end
      end
    end
  end
end
