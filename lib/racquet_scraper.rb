# Responsible for scraping my web page(s)
# This file will use nologiri, i.e. scarpe.
# This file will never use puts

# create scraper to scrape brand specific racquets
class RacquetScraper
  DICKS_URL = "https://www.dickssportinggoods.com".freeze
  BASE_URL = "#{DICKS_URL}/f/tennis-racquets?pageNumber=0&pageSize=136".freeze

  attr_accessor :page

  def initialize
    @page = Nokogiri::HTML(HTTParty.get(BASE_URL).body)
  end

  def scrape_racquets
    page.css(".dsg-react-product-card").each do |racquet|
      brand = Brand.find_or_create_by_name(name(racquet).split(" ")[0])
      Racquet.new(
        name(racquet), price(racquet), rating(racquet), url(racquet), brand
      )
    end
  end

  def scrape_racquets_page(racquet)
    racquet_page = Nokogiri::HTML(HTTParty.get(racquet.url).body)
    racquet.info = racquet_page.css(".product-component").css("p").text
  end

private

  def rating(racquet_element)
    racquet_element.css(".rs_rating_container a").first
    &.attributes&.dig("aria-label")&.value&.split(" ")&.last.to_f
  end

  def url(racquet_element)
    DICKS_URL + racquet_element.css(".card_image a").attr("href").text
  end

  def price(racquet_element)
    racquet_element.css(".rs_item_price").text
  end

  def name(racquet_element)
    racquet_element.css("a").first.attributes.dig("aria-label").text.upcase
  end
end
