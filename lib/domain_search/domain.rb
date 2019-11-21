class DomainSearch::Domain

  attr_accessor :name, :available, :confidence, :price
  @@all = []

  def initialize(name, available, confidence, price=nil)
    @name, @available, @confidence, @price = name, available, confidence, price
    @@all << self
  end

  def self.create_domain_object(name)
    api_return = APIScrape.get_domain(name)
    if api_return
    domain_object = api_return["DomainAvailableResponse"]
    domain_object_instance = DomainSearch::Domain.new(domain_object["Domain"],
        domain_object["Available"], domain_object["Definitive"], domain_object["Price"])
    else
      puts "No domain was found based on your search term.  Please try a different search term."
      DomainSearch::CLI.search_verification
    end
  end

  def self.all
    @@all
  end

  def self.all_destroy
    @@all.clear
  end
end
