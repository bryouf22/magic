class Crawler::RetrieveDataFromUrl
  include Interactor

  def call
    context.card_data = CardCrawler.new(context.url).retrieve_data(context.url)
  end
end
