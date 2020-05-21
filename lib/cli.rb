# This class is respobsivle for communication with the user
# This is where I will use 'puts'
# This will never use nokogiri
# This will have to invoke Scraper

class Cli
  def call
    BrandScraper.new.scrape_brands
    RacquetScraper.new.scrape_racquets
    welcome
    start
  end

    # user picks racuet
    # dig into racquet show page - url


  def welcome
    puts " "
    puts "Welcome to your virtual tennis racquet assistant!".bold
    puts "I will show you available racquets and info based on a specific brand.".bold
    puts " "
  end

  def start
    list_brands
    loop do
      prompt_to_input
      input = gets.strip

      if input == "exit"
        goodbye_message
        exit
      elsif input.to_i >= 1 && input.to_i <= 6
        brand = brand_locator(input.to_i)
        racquets_by_brand(brand)
        # prompt_racquet_choice
      elsif puts "Invalid entry, please choose a brand from 1 - 6".colorize(:red).bold
        puts " "
        start
      end
    end
  end

  def list_brands
    Brand.all.each_with_index do |brand, index|
      puts " #{index + 1}  " + brand.name
      puts "--------------------------------------"
    end
  end

  def prompt_to_input
    puts " "
    puts "Please select a brand by its corrisponding #, " \
         "or type exit to quit:".colorize(:green).bold
  end

  def goodbye_message
    puts "See you later, have a great day!"
  end

  def brand_locator(input)
    Brand.find_by_id(input)
  end


  def racquets_by_brand(brand)
    puts " "
    puts "Here are all the #{brand.name} racquet's that we carry."
    puts " "

    Racquet.select_by_brand(brand).each_with_index do |racquet, index|
      puts " #{index + 1}  #{racquet.name} ~~~~ " \
           "#{racquet.price} ~~~~ #{racquet.rating}"
      puts " "
    end
    # racquet_link
  end




end