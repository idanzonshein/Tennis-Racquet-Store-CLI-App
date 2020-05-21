# Responsible for the blueprint of a tennis raquet
# This will never use nokogiri
# It will never use puts
# Store all of my tennis_raquet data, i.e. attributes

class Racquet

  attr_accessor :name, :price, :rating, :url, :brand

  @@all = []

  def initialize(name = nil, price = nil, rating = nil, url = nil, brand = nil)
    @name = name
    @price = price
    @rating = rating
    @url = url
    @brand = brand
    @@all << self
  end

  def self.all
    @@all
  end

end