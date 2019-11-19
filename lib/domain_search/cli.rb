class DomainSearch::CLI

  def call
    puts "Welcome to Domain Search using GoDaddy API!"
    menu
  end

  def menu
    puts <<-DOC
    Menu Options
    1. Search for status of specific domain
    2. Search for available domains based on keyword
    Q or q to quit program

    DOC
  end

end
