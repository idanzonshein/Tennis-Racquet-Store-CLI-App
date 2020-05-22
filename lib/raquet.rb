# Responsible for the blueprint of a tennis raquet
# This will never use nokogiri
# It will never use puts
# Store all of my tennis_raquet data, i.e. attributes

class Racquet
  attr_accessor :name, :price, :rating, :url, :brand, :info, :id

  @@all = []

  def initialize(name, price, rating, url, brand)
    @name = name
    @price = price
    @rating = rating
    @url = url
    @brand = brand
    @@all << self
    @id = @@all.count
  end

  def self.all
    @@all
  end

  def self.select_by_brand(brand)
    all.select { |raquet| raquet.brand == brand }
  end
end
