class BaseCrawler
  require 'open-uri'
  require 'uri'

  GATHERER_BASE_URL = 'https://gatherer.wizards.com/Pages'

  # BaseCrawler.new.import_new_extensions
  def import_new_extensions
    import_set_names.each do |set_name|
      set_id = retrieve_or_create_set(set_name)
      retrieve_urls(set_name).each do |card_url|
        next if card_url.include?('&part=') && set_name == 'Throne of Eldraine'
        CardCrawler.new(card_url, set_id)
      end
    end
  end

  # only for local use
  def import_fail_url
    gurls_ids = []
    GathererCardUrl.where(extension_set_id: 217).each do |gurl|
      if gurl.url.include?('&part=')
        gurls_ids << gurl.id
        next
      end
      CardCrawler.new(gurl.url, 217)
    end
    GathererCardUrl.where(id: gurls_ids).destroy_all
  end

  def retrieve_urls(set_name)
    hrefs = []
    page = 0
    loop do
      html = html_from_url("#{GATHERER_BASE_URL}/Search/Default.aspx?action=advanced&set=[%22#{extension_set_name_for_url(set_name)}%22]&page=#{page}")
      card_urls = html.css('span.cardTitle a').collect { |a| a.attribute('href').value.sub('..', GATHERER_BASE_URL) }
      break if hrefs.include?(card_urls.first) || card_urls.empty?
      hrefs += card_urls
      page += 1
    end
    hrefs
  end

  protected

  def html_from_url(url)
    client = HTTPClient.new(default_header: default_header).get(url)
    Nokogiri::HTML(client.body)
  end

  def rotate_double_visual?(set_id)
    case ExtensionSet.find(set_id).name
    when 'Throne of Eldraine'
      false
    else
      true
    end
  end

  private

  def retrieve_or_create_set(set_name)
    name = set_name.gsub("+", ' ').gsub("%3a", ': ')
    if (set = ExtensionSet.where(name: name).first)
      set.id
    else
      ExtensionSet.create(name: name).id
    end
  end

  def import_set_names
    [
      'Ikoria Commander',
      'heros Beyond Death',
      'Ikoria%3a Lair of Behemoths',
    ]
  end

  def default_header
    { 'Accept-Language' => 'en-US' }
  end

  def extension_set_name_for_url(set_name)
    set_name.gsub(" ", "%20")
  end

  def alternative_types(set_name)
    if set_name == "Throne of Eldraine"
      :adventure
    else
      0
      # TODO see model alternative for mapping

      # recto_verso: 1,
      # double_card: 2,
      # flip_card:   3,
      # adventure:   4
    end
  end
end
