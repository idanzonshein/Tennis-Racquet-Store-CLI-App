# create scraper to scrape all brands
class BrandScraper
  attr_accessor :page

  def initialize
    @page = Nokogiri::HTML(
      HTTParty.get(
        "https://www.dickssportinggoods.com/f/tennis-racquets?pageNumber=0"
      ).body
    )
  end

  # scrapes brand list
  def scrape_brands
    page.css(
      "#facet_list_X_BRAND .dsg-responsive-checkbox-wrapper .facet-value"
    ).each do |brand_list|
      name = brand_list.children.text.upcase
      Brand.new(name)
    end
  end
end
