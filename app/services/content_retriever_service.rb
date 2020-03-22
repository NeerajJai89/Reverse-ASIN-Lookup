class ContentRetrieverService
  attr_reader :asin

  def initialize(asin:)
    @asin = asin
  end

  def get_content
    #Selenium::WebDriver::Chrome.driver_path="/usr/bin/chromedriver"
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    browser = Selenium::WebDriver.for :chrome, options: options
    browser.get path
    Nokogiri::HTML.parse(browser.page_source)
    browser.close()
  end

  private

  def path
    @path ||= "http://www.amazon.com/dp/#{asin}"
  end
end
