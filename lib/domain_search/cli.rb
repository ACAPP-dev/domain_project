class DomainSearch::CLI

  attr_accessor :domain

  def call
    puts "Welcome to Domain Search using GoDaddy API!"
    main_menu
  end

  def main_menu
    puts <<-DOC
    Menu Options
    1. Search for status of specific domain
    2. Search for available domains based on keyword
    Q or Quit to exit the program
    DOC
    input = gets.strip.downcase
    if input == "1" || input == "one"
      puts "Enter domain for search:"
      search_verification(input)
    elsif input == "2" || input == "two"
      puts "Enter keyword for search:"
      search_verification(input)
    elsif input == "q" || input == "quit"
      puts "Goodbye!"
    else
      puts "Please enter a valid menu option:"
      main_menu
    end
  end

  def second_menu(name=nil)
    puts <<-DOC
      Choose number of domain to view more detail:
      E or Exit to go back to main menu
    DOC
    input = gets.strip.downcase
    if input == "e" || input == "exit"
      DomainSearch::DomainList.all_destroy
      main_menu
    elsif input.to_i >= 1 && input.to_i <= DomainSearch::DomainList.all.length
      display_search_keyword_details(DomainSearch::DomainList.all[input.to_i-1])
    else
      puts "Please enter a valid menu option:"
      second_menu(name)
    end
  end

  def third_menu
    puts <<-DOC
      B or Back to return to the list of domains
      E or Exit to go back to main menu
      Q or Quit to exit the program
    DOC
    input = gets.strip.downcase
    if input == "b" || input == "back"
      display_search_keyword_results
    elsif input == "e" || input == "exit"
      DomainSearch::DomainList.all_destroy
      main_menu
    elsif input == "q" || input == "quit"
      puts "Goodbye!"
    else
      puts "Please enter a valid menu option:"
      second_menu
    end
  end

  def search_verification(input)
    search_input = gets.strip.downcase
    if search_input.match?(/^[a-zA-Z]{1,20}\.?[a-zA-Z]{0,12}$/)
      search_specific(search_input) if input == "1" || input == "one"
      search_keyword(search_input) if input == "2" || input == "two"
    else
      puts "Please enter valid search text (1-20 word characters plus optional '.' plus optional 0-12 for top level domain):"
      search_verification(input)
    end
  end

  def search_specific(name)
    domain_scrape = APIScrape.get_domain(name)
    domain_return = DomainSearch::Domain.create_domain_object(domain_scrape)
    display_search_specific_results(domain_return)
  end

  def search_keyword(keyword)
    domain_list_scrape = APIScrape.get_domain_list(keyword)
    domain_list_array = DomainSearch::DomainList.create_domain_list(domain_list_scrape)
    domain_list_hash = APIScrape.get_domain_list_info(domain_list_array)
    DomainSearch::DomainList.add_domain_list_details(domain_list_hash)
    puts "Domain listing based on keyword: #{keyword}"
    display_search_keyword_results
  end

  def display_search_specific_results(object)
    puts <<-DOC
    Domain Search Results:
    Domain Name: #{object.name}
    Available for Purchase? #{object.available}
    Is GoDaddy Confident of Status? #{object.confidence}
    Price: #{object.price}
    DOC
    if object.available == "true"
      main_menu
    else
      puts "Your requested domain is not available.  Here is a list of related domains:"
      search_keyword(object.name)
    end
  end

  def display_search_keyword_results
    display_list = DomainSearch::DomainList.all
    #binding.pry
    display_list.each.with_index(1) do |object, index|
      puts "#{index}. #{object.name}      #{object.price}"
    end
    second_menu
  end

  def display_search_keyword_details(object)
    puts <<-DOC
    Domain Details:
    Domain Name: #{object.name}
    Available for Purchase? #{object.available}
    Is GoDaddy Confident of Status? #{object.confidence}
    Price: #{object.price}
    DOC
    if object.available
      puts "This domain is available for purchase!"
      third_menu
    else
      puts "Your requested domain is not available.  Maybe you can try another option?"
      third_menu
    end
  end
end
