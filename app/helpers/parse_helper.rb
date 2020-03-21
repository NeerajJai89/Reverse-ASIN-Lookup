module ParseHelper

  def parse_category(raw_category)
    regex = %r{(?<category>\w+(.\w+)*)}
    parsed = parse_raw_content(raw_category, regex)
    return "Not Available" unless parsed.present?
    parsed[:category]
  end

  def parse_rank(raw_rank)
    regex = %r{(?<rank>#.+?)(?=\s\()}
    parsed = parse_raw_content(raw_rank, regex)
    return "Not Available" unless parsed.present?
    parsed[:rank]
  end

  def parse_dimensions(raw_dimensions)
    regex = %r{(?<dimensions>\w.+$)}
    parsed = parse_raw_content(raw_dimensions, regex)
    return "Not Available" unless parsed.present?
    parsed[:dimensions]
  end

  private

  def parse_raw_content(raw_content, regex)
    return "" unless raw_content
    raw_content.match(regex)
  end
end
