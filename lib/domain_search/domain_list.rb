class DomainSearch::DomainList

  attr_accessor :name, :available, :confidence, :price
  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.create_domain_list(domain_listing)
    domain_listing.each do |domain_item|
      domain_list_instance = DomainSearch::DomainList.new(domain_item["domain"])
    end
    DomainSearch::DomainList.all
  end

  def self.add_domain_list_details(domain_info_hash)
    domain_info_hash["domains"].each do | domain|
      current_instance = DomainSearch::DomainList.all.detect{|object| object.name == domain["domain"]}
      if current_instance
        current_instance.available = domain["available"]
        current_instance.confidence = domain["definitive"]
        current_instance.price = domain["price"].to_f/1000000
      end
    end
    DomainSearch::DomainList.all
  end

  def self.all
    @@all
  end

  def self.all_destroy
    @@all.clear
  end
end
