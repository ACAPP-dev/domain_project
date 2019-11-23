class APIScrape

  BASEURL = "https://api.ote-godaddy.com/v1/domains"
  KEY = "3mM44UaChQSbDX_Cz2Z8oBLkQgCGLqvmQHTAN"
  SECRET = "Jb9VdYd35vbRNeqVyFygk5"

  def self.get_domain(name)
    url = "#{BASEURL}/available?domain=#{name}"
    response = HTTParty.get(url, :headers => {"Authorization" => "sso-key #{KEY}:#{SECRET}", "accept" => 'application/xml'})
  end

  def self.get_domain_list(keyword)
    url = "#{BASEURL}/suggest?query=#{keyword}&limit=20&waitMS=1000"
    response = HTTParty.get(url, :headers => {"Authorization" => "sso-key #{KEY}:#{SECRET}"})
  end

  def self.get_domain_list_info(domain_list_array)
    domains = []
    url = "#{BASEURL}/available?"
    domain_list_array.each do |object|
      domains << object.name
    end
    response = HTTParty.post(url, :headers => {"Authorization" => "sso-key #{KEY}:#{SECRET}", "Content-Type" => "application/json"}, :body => domains.to_json)
  end
end
