class DomainSearch::Domain

  attr_accessor :name, :available, :confidence, :price
  @@all = []

  def initialize(name, available, confidence, price=nil)
    @name, @available, @confidence, @price = name, available, confidence, price

    @@all << self
  end

  def self.create_domain_object(object)
    #object["DomainAvailableResponse"].each do |key, value|
    #  if key == "Available"
    #    available = value
    #  if key == "Confidence"
    #    confidence == value
    #  if key == "Domain"
    #    name = value
    #  if key == "Price"
    #    price = value
    #  end
    #end
    domain_object = object["DomainAvailableResponse"]
    domain_object_instance = DomainSearch::Domain.new(domain_object["Domain"], domain_object["Available"], domain_object["Definitive"], domain_object["Price"])
    #binding.pry

  end

  def self.all
    @@all
  end


end
