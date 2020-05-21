# This class is respobsivle for communication with the user
# This is where I will use 'puts'
# This will never use nokogiri
# This will have to invoke Scraper

class Cli
  def call
    BrandScraper.new.scrape_brands
    RacquetScraper.new.scrape_racquets
    welcome
    # puts all brands
    # pick a brand
    # input = gets.strip
    # brand = Brand.find_by_name(input)
    # racquets = Racquet.for_brand(brand) #=> all the racquets for brand X
    # puts all the racquets
    # user picks racuet
    # dig into racquet show page - url
  end

  def welcome
    puts "Welcome to your virtual tennis racquet assistant!"
    puts "I will show you available racquets and info based on a specific brand."
  end

  def list_brands

  end







end