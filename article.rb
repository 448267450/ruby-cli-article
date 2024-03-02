require_relative "user"

class Article 

  @@author_book_map = {
    "Charles Dickens" => "Great Expectations",
    "Jane Austen" => "Pride and Prejudice",
    "Leo Tolstoy" => "War and Peace"
  }

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

  def selectBookByAuthor(attr_writer)
    book = self.class.author_book_map[attr_writer]
    if book
      book +  " was selected!"
    else
      "No book found for author #{attr_writer}"
    end
  end

  def search_article
    print "Please enter the writer name: "
    attr_writer = gets.chomp.strip
    attr_writer = "Unknown Writer" if attr_writer.empty?


    print "Please enter your own name: "
    attr_reader = gets.chomp.strip 
    attr_reader = "Unknown Reader" if attr_reader.empty?

    selected_book = selectBookByAuthor(attr_writer)
    @articles << { author: attr_writer, book: selected_book, reader: attr_reader }
    puts "Article searched successfully"
  end 

  def show_articles
    puts "Articles selected in the collection"
    @articles.each do |article|
      puts "Author: #{article[:author]}, Book: #{article[:book]}, Reader: #{article[:reader]}"
    end
  end

  def self.author_book_map
    @@author_book_map
  end 
end
