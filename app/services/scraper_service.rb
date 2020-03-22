class ScraperService
  attr_reader :doc, :asin

  def initialize(asin:)
    @asin = asin
    @doc = ContentRetrieverService.new(asin: asin).get_content
  end

  def scrape
    {
      category: parse_data(scrape_category,'category'),
      rank: parse_data(scrape_rank,'rank'),
      dimensions: parse_data(scrape_dimensions,'dimensions'),
      asin: asin
    }
  end

  private

  def parse_data(raw_data,content)
    if content == 'rank'
      regex = %r{(?<#{content}>#.+?)(?=\s\()}
    elsif content == 'category'
        regex = %r{(?<#{content}>\w+(.\w+)*)}
    else
        regex = %r{(?<#{content}>\w.+$)}
    end
    parsed = parse_raw_content(raw_data, regex)
    if content == 'category'
      return "" unless parsed.present?
    else
      return "Not Available" unless parsed.present?
    end
    
    
    parsed["#{content}"]
  end

  def parse_raw_content(raw_content, regex)
    return "" unless raw_content
    raw_content.match(regex)
  end

  def scrape_dimensions
    path = "//*[contains(text(),'Product Dimensions')]/following-sibling::td"
    main_element_path = doc.xpath(path).try(:text)
    return main_element_path if main_element_path.present?

    doc.xpath("//*[contains(text(),'Item Dimensions')]/following-sibling::td/span[0]").try(:text)
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
