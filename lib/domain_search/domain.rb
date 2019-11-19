class DomainSearch::Domain

  attr_accessor :name, :available, :confidence, :price
  @@all = []

  def initialize(name, available, confidence, price=nil)
    @name, @available, @confidence, @price = name, available, confidence, price
    @@all << self
  end




end
