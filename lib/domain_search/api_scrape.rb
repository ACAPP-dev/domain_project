require 'httparty'

class APIScrape

  def self.get_domain(name)
    url = "https://api.ote-godaddy.com/v1/domains/available?domain=#{name}"
    response = HTTParty.get(url, :headers => {"Authorization" => "sso-key 3mM44UaChQSbDX_Cz2Z8oBLkQgCGLqvmQHTAN:Jb9VdYd35vbRNeqVyFygk5", "accept" => 'application/xml'})
  end

  def self.get_domain_list(keyword)
    url = "https://api.ote-godaddy.com/v1/domains/suggest?query=#{keyword}&limit=50&waitMS=1000"
    response = HTTParty.get(url, :headers => {"Authorization" => "sso-key 3mM44UaChQSbDX_Cz2Z8oBLkQgCGLqvmQHTAN:Jb9VdYd35vbRNeqVyFygk5"})
  end

end
