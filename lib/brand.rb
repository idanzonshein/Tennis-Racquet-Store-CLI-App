class Brand
  attr_reader :name

  @@all = []

  def initialize(name = nil)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    all.find do |brand|
      brand.name == name
    end
  end
end
