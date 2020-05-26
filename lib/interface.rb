class Interface
  class << self
    include Color
    def list_error
      puts_red "Sorry we are currently out of stock!"
      puts_red "Select another brand or 'exit' to leave"
    end

    def welcome_message
      puts_green "\nWelcome to your virtual tennis racquet assistant!"
      puts_green "I will show you available racquets and info " \
      "based on a specific brand.\n\n"
    end

    def puts_racquet_list(brand_list)
      brand_list.each_with_index do |racquet, index|
        rating = if racquet.rating.positive?
                   racquet.rating.round(2).to_s + "/5"
                 else
                   "n/a"
                 end
        name_with_number = "#{index + 1}  #{racquet.name}"
        puts " \n#{name_with_number} ~~~~ #{racquet.price} ~~~~ #{rating}"
      end
    end
  end
end
