require 'proxycrawl'
class CrawlerService
  attr_reader :asin

  def initialize(asin:)
    @asin = asin
  end

  def get_content

    api = ProxyCrawl::API.new(token: ENV['CRAWLER_TOKEN'])
    html = api.get(url)
    Nokogiri::HTML(html.body)
    # options = Selenium::WebDriver::Chrome::Options.new
    # options.add_argument('--headless')
    # options.add_argument('--no-sandbox')
    # browser = Selenium::WebDriver.for :chrome, options: options
    # browser.get url
    # Nokogiri::HTML.parse(browser.page_source)

    # html = open(path, "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36").read
    # Nokogiri::HTML.parse(html)
    
  end


  private

  def url
    @url ||= "http://www.amazon.com/dp/#{asin}"
  end
end
