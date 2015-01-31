require "cobweb"
require_relative "../jobs/index_page"

class Crawler
  def initialize(args = {})
    @crawler = args.fetch(:crawler_engine) { CobwebCrawler.new }
    @index_page_enqueuer = args.fetch(:index_page_enqueuer) { IndexPage.method(:enqueue) }
  end

  def site_map
    @statistics ||= statistics
  end

  private

  attr_reader :crawler, :index_page_enqueuer

  def statistics
    Hash.new.tap do |statistics|
      crawler.crawl(url) do |page|
        statistics[page.fetch(:url)] = index_page_enqueuer.call(page)
      end
    end
  end

  private

  def url
    "https://gocardless.com/"
  end
end
