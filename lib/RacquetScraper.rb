# Responsible for scraping my web page(s)
# This file will use nologiri, i.e. scarpe.
# This file will never use puts

# create scraper to scrape brand specific racquets
class RacquetScraper

  BASE_URL = "https://www.dickssportinggoods.com/f/tennis-racquets?pageNumber=0&pageSize=136"
  DICKS_URL = "https://www.dickssportinggoods.com"

  attr_accessor :page

  def initialize
    @page = Nokogiri::HTML(HTTParty.get(BASE_URL).body)
  end

  def scrape_racquets
    # ind_page.css(".dsg-react-product-card").each do |racquet|
    page.css(".dsg-react-product-card").each do |racquet|
      name = racquet.css("a").first.attributes.dig("aria-label").text.upcase
      price = racquet.css(".rs_item_price").text
      rating = racquet.css(".rs_rating_container a").first&.attributes&.dig("aria-label")&.value&.split(" ")&.last.to_f
      url = DICKS_URL + racquet.css(".card_image a").attr("href").text
      brand = Brand.find_or_create_by_name(name.split(" ")[0])
      Racquet.new(name, price, rating, url, brand)
    end
  end

  def scrape_racquets_page(racquet)
    racquet_page = Nokogiri::HTML(HTTParty.get(racquet.url).body)
    racquet.info = racquet_page.css(".product-component").css("p").text
  end
end
