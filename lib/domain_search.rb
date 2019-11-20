require_relative "./domain_search/version"
require_relative "./domain_search/cli"
require_relative "./domain_search/api_scrape"
require_relative "./domain_search/domain"
require_relative "./domain_search/domain_list"
require 'pry'

module DomainSearch
  class Error < StandardError; end
  # Your code goes here...
end
