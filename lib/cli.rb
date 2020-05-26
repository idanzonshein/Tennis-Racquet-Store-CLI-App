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
    puts_green "\nWelcome to your virtual tennis racquet assistant!"
    puts_green "I will show you available racquets and info " \
    "based on a specific brand.\n\n"
  end

  def start
    list_brands
    brand_loop
  end

  def brand_loop
    loop do
      input = prompt_to_input
      if input == "exit"
        goodbye_message
      elsif input.to_i >= 1 && input.to_i <= 6
        process_brand(input.to_i)
      elsif puts_red "Invalid entry, please choose a brand from 1 - 6\n\n"
        start
      end
    end
  end

  def process_brand(input)
    brand = brand_locator(input)
    list_by_brand(brand)
    prompt_racquet_choice(brand)
  end

  def list_brands
    Brand.all.each_with_index do |brand, index|
      puts " #{index + 1}  " + brand.name
      puts "-------------------"
    end
  end

  def prompt_to_input
    puts_green "\nPlease select a brand by its corrisponding #, " \
               "or type exit to quit:"
    gets.strip.downcase
  end

  def goodbye_message
    puts_green "See you later, have a great day!"
    exit
  end

  def brand_locator(input)
    Brand.find_by_id(input)
  end

  def list_by_brand(brand)
    puts "Here are the #{brand.name} racquets.\n\n".colorize(:light_blue)
    racquet_list_conditional(brand)
  end

  def prompt_racquet_choice(brand)
    puts_green "\nSelect a racquet # to read a brief " \
          "overview or enter 'back' to select another brand"
    user_input(brand)
  end

  def racquet_description(racquet)
    RacquetScraper.new.scrape_racquets_page(racquet)
    puts "Info:".colorize(:red).on_blue.bold
    puts "#{racquet.info} "
    puts_green "\nSelect another racquet # for info " \
    "or 'back' to choose new brand"
  end

  def user_input(brand)
    racquets_for_brand = Racquet.select_by_brand(brand)
    loop do
      input = gets.strip
      if input == "back"
        start
      elsif input.to_i >= 1 && input.to_i <= racquets_for_brand.length
        racquet = racquets_for_brand[input.to_i - 1]
        racquet_description(racquet)
      elsif puts_red "Invalid entry, select valid # or 'back' to return \n\n"
      end
    end
  end

  def racquet_locator(input)
    Racquet.find_by_id(input)
  end

  def racquet_list_conditional(brand)
    if Racquet.select_by_brand(brand).any?
      Racquet.select_by_brand(brand).each_with_index do |racquet, index|
        puts " \n#{index + 1}  #{racquet.name} ~~~~ " \
          "#{racquet.price} ~~~~ " \
          "#{racquet.rating.positive? ? racquet.rating.round(2).to_s + '/5' : 'n/a'}"
      end
    else
      Interface.list_error
      brand_loop
    end
  end

private

  def puts_green(string)
    puts string.colorize(:green).bold
  end

  def puts_red(string)
    puts string.colorize(:red).bold
  end
end
