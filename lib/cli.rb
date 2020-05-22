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

  def welcome
    puts " "
    puts "Welcome to your virtual tennis racquet assistant!".colorize(:green).bold
    puts "I will show you available racquets and info " \
    "based on a specific brand.".colorize(:green).bold
    puts " "
  end

  def start
    puts " "
    list_brands
    loop do
      prompt_to_input
      input = gets.strip

      if input == "exit"
        goodbye_message
        exit
      elsif input.to_i >= 1 && input.to_i <= 6
        brand = brand_locator(input.to_i)
        list_by_brand(brand)
        prompt_racquet_choice(brand)
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

  def list_by_brand(brand)
    puts " "
    puts "Here are all the #{brand.name} racquet's that we carry."
    puts " "
    Racquet.select_by_brand(brand).each_with_index do |racquet, index|
      puts " #{index + 1}  #{racquet.name} ~~~~ " \
          "#{racquet.price} ~~~~ #{racquet.rating}"
      puts " "
    end
  end

  def prompt_racquet_choice(brand)
    puts " "
    puts  "Select a racquet # to read a brief " \
          "overview or enter 'back' to select another brand".colorize(:green).bold
    user_input(brand)
  end

  def racquet_description(racquet)
    RacquetScraper.new.scrape_racquets_page(racquet)
    puts "Info:".colorize(:red).on_blue.bold
    puts "#{racquet.info} "
    puts " "
    puts "Select another racquet # for info " \
    "or 'back' to choose new brand".colorize(:green).bold
  end

  def user_input(brand)
    loop do
      input = gets.strip
      if input == "back"
        start
      elsif input.to_i >= 1
        racquet = Racquet.select_by_brand(brand)[input.to_i - 1]
        racquet_description(racquet)
      elsif puts "Invalid entry".colorize(:red).bold
        puts " "
      end
    end
  end

  def racquet_locator(input)
    Racquet.find_by_id(input)
  end
end
