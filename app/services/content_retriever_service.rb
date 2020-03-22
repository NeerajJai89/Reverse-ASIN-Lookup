class ContentRetrieverService
  attr_reader :asin

  def initialize(asin:)
    @asin = asin
  end

  def get_content
    begin
      options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    browser = Selenium::WebDriver.for :chrome, options: options
    p 'reached here'

    browser.get path
    p browser.page_source
    Nokogiri::HTML.parse(browser.page_source)
    browser.quit()
    rescue => ex
      p ex
    end
    #Selenium::WebDriver::Chrome.driver_path="/usr/bin/chromedriver"
    
  end

  private

  def path
    @path ||= "http://www.amazon.com/dp/#{asin}"
  end
end
