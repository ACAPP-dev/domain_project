class DomainSearch::CLI

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
      search_input = gets.strip
      search_specific(search_input)
    elsif input == "2" || input == "two"
      puts "Enter keyword for search:"
      keyword_input = gets.strip
      search_keyword(keyword_input)
    elsif input == "q" || input == "quit"
      puts "Goodbye!"
    else
      puts "Please enter valid menu option:"
      main_menu
    end
  end

  def second_menu
    puts <<-DOC
      Choose number of domain to view:
      N or next to show next 10 options
      E or exit to go back to main menu
    DOC
  end

  def search_specific(name)
    puts <<-DOC
    Domain name
    Available: Yes
    Price: $50.00
    DOC
    #Need to add list of similar domains if not available
  end

  def search_keyword(keyword)
    puts <<-DOC
    1. xxxx.xxx
    2. xxxx.xxx
    3. xxxx.xxx
    DOC

  end

end
