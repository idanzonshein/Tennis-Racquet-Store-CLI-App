# This class is respobsivle for communication with the user
# This is where I will use 'puts'
# This will never use nokogiri
# This will have to invoke Scraper

class Cli
  def call
    BrandScraper.new.scrape_brands
    RacquetScraper.new.scrape_racquets
    welcome
    list_brands
    prompt_to_input
    input = gets.strip.to_i
    input_condtion(input)

    # brand = Brand.find_by_name(input)
    # racquets = Racquet.for_brand(brand) #=> all the racquets for brand X
    # puts all the racquets
    # user picks racuet
    # dig into racquet show page - url
  end

  def welcome
    puts "Welcome to your virtual tennis racquet assistant!"
    puts "I will show you available racquets and info based on a specific brand."
    puts " "
  end

  def list_brands
    Brand.all.each_with_index do |brand, index|
      puts " #{index}  " + brand.name[:name]
      puts "--------------------------------------"
    end
  end

  def prompt_to_input
    puts " "
    puts "Please select a brand by its corrisponding number."
  end

  def input_condtion(input)
    if input >= 1 && input <=6
      true
    else
      puts "Invalid entry, please choose a brand from 1 - 6"
      call
    end
  end
end