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
    

  end

  def self.all
    @@all
  end


end