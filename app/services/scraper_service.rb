class ScraperService
  include ParseHelper
  attr_reader :doc, :asin

  def initialize(asin:)
    @asin = asin
    @doc = ContentRetrieverService.new(asin: asin).get_content
  end

  def scrape
    {
      category: parse_category(scrape_category),
      rank: parse_rank(scrape_rank),
      dimensions: parse_dimensions(scrape_dimensions),
      asin: asin
    }
  end

  private

  def scrape_dimensions
    path = "//*[contains(text(),'Product Dimensions')]/following-sibling::td"
    main_element_path = doc.xpath(path).try(:text)
    return main_element_path if main_element_path.present?

    doc.xpath("//*[contains(text(),'Product Dimensions')]/following-sibling::span").try(:text)
  end

  def scrape_category
    doc.at_css("span.a-list-item").try(:text)
  end

  def scrape_rank
    path = "//*[contains(text(),'Best Sellers Rank')]/following-sibling::td/span[1]/span[1]"
    main_element_path = doc.xpath(path).try(:text)
    return main_element_path if main_element_path.present?
    secondary_element_path = doc.at_css("#SalesRank").try(:text)
    return secondary_element_path if secondary_element_path.present?
    doc.xpath("//table[@class='a-keyvalue prodDetTable']/tbody/tr[7]/td").try(:text)
  end
end
