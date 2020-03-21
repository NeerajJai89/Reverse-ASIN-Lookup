class ContentRetrieverService
  attr_reader :asin

  def initialize(asin:)
    @asin = asin
  end

  def get_content
    browser = Watir::Browser.new(:chrome, headless: true)
    browser.goto(path)
    Nokogiri::HTML.parse(browser.html)
  end

  private

  def path
    @path ||= "http://www.amazon.com/dp/#{asin}"
  end
end
