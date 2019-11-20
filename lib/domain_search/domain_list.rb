class DomainSearch::DomainList

  attr_accessor :name
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

  def self.all
    @@all
  end


end
