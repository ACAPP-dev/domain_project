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
    Q or q to quit program
    DOC
    input = gets.strip.downcase
    #binding.pry
    if input == "1" || input == "one"
      puts "Enter domain for search:"
      search_input = gets.strip.downcase
      search_specific(search_input)
    elsif input == "2" || input == "two"
      puts "Enter keyword for search:"
      keyword_input = gets.strip
      search_keyword(keyword_input)
    elsif input == "q" || input == "quit"
      puts "Goodbye!"
    else
      puts "Please enter a valid menu option:"
      main_menu
    end
  end

  def second_menu(name=nil)
    puts <<-DOC
      Choose number of domain to view:
      N or next to show next 10 options
      B or back to show previous 10 options
      E or exit to go back to main menu
    DOC
    #will need way to choose multiple options from array or hash
    input = gets.strip.downcase
    #binding.pry
    if input == "1" || input == "one"
      search_specific(name)
    elsif input == "n"|| input == "next"
      puts "Showing up to next 10 options"
      second_menu(name)
    elsif input == "b" || input == "back"
      puts "Showing previous 10 options"
      second_menu(name)
    elsif input == "e" || input == "exit"
      main_menu
    else
      puts "Please enter a valid menu option:"
      second_menu(name)
    end
  end

  def search_specific(name)

    domain_scrape = APIScrape.get_domain(name)
    domain_return = DomainSearch::Domain.create_domain_object(domain_scrape)


    puts <<-DOC
    Domain Search Results:
    Domain Name: #{domain_return.name}
    Available for Purchase: #{domain_return.available}
    Is GoDaddy Confident of Status?: #{domain_return.confidence}
    Price: #{domain_return.price}
    DOC
    #@domain = DomainSearch::Domain.all
    available = false
    if available
      main_menu
    else
      puts "Your requested domain is not available.  Here is a list of related domains for sale:"
      search_keyword(name)

    #Need to add list of similar domains if not available
    end
  end

  def search_keyword(keyword)
    i = 0
    domain_list_scrape = APIScrape.get_domain_list(keyword)
    domain_list_array = DomainSearch::DomainList.create_domain_list(domain_list_scrape)
    domain_list_hash = APIScrape.get_domain_list_info(domain_list_array)
    puts "Domain listing based on keyword: #{keyword}"
    if domain_list_array.length > 10
      while i < 10
        #puts first 10 Results
        puts "#{i+1}. #{domain_list_array[i].name}"
        i += 1
      end
    else
      while i < domain_list_array.length
        puts "#{i+1}. #{domain_list_array[i].name}"
        i += 1
      end
    end



    #domain_list_array.each do |domain_item|
    #  puts
    #end
    #puts <<-DOC
    #1. xxxx.xxx
    #2. xxxx.xxx
    #3. xxxx.xxx
    #DOC
    second_menu(keyword)
  end

end
