require_relative "article"

class Library 
  def initialize  
    @articles = []
  end 

  def run 
    loop do
      puts "\n"
      puts "Welcome to the RUBY-CLI-FIRST online library"
      puts "1. Search one article"
      puts "2. Show all articles"
      puts "3. Exit"
      print "Choose an option: "
      option = gets
      if option.nil?
        puts "Error: End of input encountered. Exiting."
        break
      end
      option = option.chomp.to_i 
      puts "\n"
      case option
      when 1
        search_article
      when 2 
        show_articles
      when 3
        puts "Thanks for visiting this online library. GoodBye!"
        break
      else 
        puts "Invalid option selected, please try again!"
      end
    end
  end 

      

  private

  def search_article
    print "Please enter the writer name: "
    attr_writer = gets.chomp.strip
    attr_writer = "Unknown Writer" if attr_writer.empty?


    print "Please enter your own name: "
    attr_reader = gets.chomp.strip 
    attr_reader = "Unknown Reader" if attr_reader.empty?

    @articles << Article.new(attr_writer, attr_reader)
    puts "Article searched successfully"
  end 

  def show_articles
    puts "Articles selected in the collection"
    @articles.each do |article|
      puts article
    end
  end
end
