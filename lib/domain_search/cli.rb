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
      puts "Enter domain name for search (format as: name.tld e.g. 'pets.com'):"
      domain_search_verification
    elsif input == "2" || input == "two"
      puts "Enter keyword for search:"
      search_keyword_verification
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

  def domain_search_verification
    search_input = gets.strip.downcase
    if search_input.match?(/^[a-zA-Z]{1,20}\.[a-zA-Z]{1,12}$/)
      search_specific(search_input)
    else
      puts "Please enter valid search text (1-20 word characters plus '.' plus 0-12 word characters for top level domain):"
      domain_search_verification
    end
  end

  def search_keyword_verification
    search_input = gets.strip.downcase
    if search_input.match?(/^[a-zA-Z]{1,20}\.?[a-zA-Z]{0,12}$/)
      search_keyword(search_input)
    else
      puts "Please enter valid search text (1-20 word characters plus optional '.' plus optional 0-12 for top level domain):"
      search_keyword_verification
    end
  end

  def search_specific(name)
    api_return = APIScrape.get_domain(name)
    if api_return.key?("error")
      puts "No domain was found based on your search term.  Please try a different search term."
      domain_search_verification
    else
      domain_return = DomainSearch::Domain.create_domain_object(api_return)
      display_search_specific_results(domain_return)
    end
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
    puts "Domain Search Results:"
    printf("%35s %s\n", "Domain Name:", "#{object.name}")
    printf("%35s %s\n", "Available for Purchase?", "#{object.available == 'false'?'NO':'YES'}")
    printf("%35s %s\n", "Is GoDaddy Confident of Status?", "#{object.confidence == 'false'?'NO - MAY NOT BE ACCURATE':'YES - APPEARS ACCURATE'}")
    printf("%35s %s\n", "Price:", "#{object.price == 0?'NO PRICE LISTED':'$#{object.price.to_s}'}")
    #{}puts <<-DOC
    #{}Domain Search Results:
    #{}Domain Name: #{object.name}
    #{}Available for Purchase? #{object.available == 'false'?'NO':'YES'}
    #{}Is GoDaddy Confident of Status? #{object.confidence == 'false'?'NO - MAY NOT BE ACCURATE':'YES - APPEARS ACCURATE'}
    #{}Price: #{object.price == 0?'NO PRICE LISTED':'$#{object.price.to_s}'}
    #{}DOC
    if object.available == "true"
      main_menu
    else
      puts "Your requested domain is not available.  Here is a list of related domains:"
      search_keyword(object.name)
    end
  end

  def display_search_keyword_results
    display_list = DomainSearch::DomainList.all
    printf("%-3s %-20s %s\n", "#", "   Domain Name", "Price")
    printf("%-3s %-20s %s\n", "---", "   -------------  ", "--------")
    display_list.each.with_index(1) do |object, index|
      printf("%-3s %-20s %s\n", "#{index}.", object.name, "#{object.price == 0?"NO PRICE LISTED":"$#{object.price.to_s}"}")
    end
    second_menu
  end

  def display_search_keyword_details(object)
    puts "Domain Details:"
    printf("%35s %s\n", "Domain Name:", "#{object.name}")
    printf("%35s %s\n", "Available for Purchase?", "#{object.available == 'false'?'NO':'YES'}")
    printf("%35s %s\n", "Is GoDaddy Confident of Status?", "#{object.confidence == 'false'?'NO - MAY NOT BE ACCURATE':'YES - APPEARS ACCURATE'}")
    printf("%35s %s\n", "Price:", "#{object.price == 0?'NO PRICE LISTED':"$#{object.price.to_s}"}")
    #puts <<-DOC
    #Domain Details:
    #Domain Name: #{object.name}
    #Available for Purchase? #{object.available == "false"?"NO":"YES"}
    #Is GoDaddy Confident of Status? #{object.confidence == "false"?"NO - MAY NOT BE ACCURATE":"YES - APPEARS ACCURATE"}
    #Price: #{object.price == 0?"NO PRICE LISTED":"$#{object.price.to_s}"}
    #DOC
    if object.available
      puts "This domain is available for purchase!"
      third_menu
    else
      puts "Your requested domain is not available.  Maybe you can try another option?"
      third_menu
    end
  end
end
