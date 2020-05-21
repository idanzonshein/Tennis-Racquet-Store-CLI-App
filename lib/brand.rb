class Brand
  attr_reader :name
  attr_accessor :id

  @@all = []

  def initialize(name = nil)
    @name = name
    @@all << self
    @id = @@all.count
  end

  def self.all
    @@all
  end

  def self.find_by_id(id)
    all.find { |brand| brand.id == id }
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || new(name)
  end

  def self.find_by_name(name)
    all.find { |brand| brand.name == name }
  end

end
