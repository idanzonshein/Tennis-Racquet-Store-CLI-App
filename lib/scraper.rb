# Responsible for scraping my web page(s)
# This file will use nologiri, i.e. scarpe.
# This file will never use puts
require "pry"

# create scraper to scrape all brands
class BrandScraper

  attr_accessor :page

  def initialize
    @page = Nokogiri::HTML(HTTParty.get("https://www.dickssportinggoods.com/f/tennis-racquets?pageNumber=0"))
  end

  # scrapes brand list
  def scrape_brands
    page.css("#facet_list_X_BRAND .dsg-responsive-checkbox-wrapper .facet-value").each do |brand_list|
      Brand.new(
        name: brand_list.children.text.upcase
      )
    end
  end
end

# create scraper to scrape brand specific racquets
class RacquetScraper

  BASE_URL = "https://www.dickssportinggoods.com/f/tennis-racquets?pageNumber=0&pageSize=136"

  attr_accessor :page

  def initialize
    @page = Nokogiri::HTML(HTTParty.get(BASE_URL))
  end

  def scrape_racquets
    # ind_page.css(".dsg-react-product-card").each do |racquet|
    page.css(".dsg-react-product-card").each do |racquet|
      name = racquet.css("a").text
      price = racquet.css(".rs_item_price").text
      rating = racquet.css(".rs_rating_container a").first&.attributes&.dig("aria-label")&.value
      url = racquet.css(".card_image a").attr("href").text
      brand = Brand.find_by_name(name)
      Racquet.new(name, price, rating, url, brand)
    end
  end

end
