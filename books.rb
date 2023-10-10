require_relative 'book'
require_relative 'person'
require_relative 'action_interface'
require_relative 'persons_module'
require 'json'

class Books < ActionInterface
  def initialize()
    @books = read_books_from_json_file
    super()
  end

  def read_books_from_json_file()
    file_path = 'books.json'
    books = []
    return books unless File.exist?(file_path)

    begin
      # Read the JSON file
      json_data = File.read(file_path)

      # Parse the JSON data into an array of hashes
      book_hashes = JSON.parse(json_data)

      # Create Book objects from each hash and add them to the array
      book_hashes.each do |hash|
        book = Book.new(hash['title'], hash['author'])
        books << book
      end
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end

    books
  end

  def save
    books_hashes = @books.map(&:to_hash)
    books_json = JSON.pretty_generate(books_hashes)
    File.write('books.json', books_json)
  end

  def list_all
    if @books.empty?
      puts 'Book list is empty. Try again'
    else
      puts "List of Books (#{@books.length}):"
      @books.each do |book|
        puts "#{book.id} - #{book.title} by #{book.author}"
      end
    end
  end

  def create
    print 'Enter the title of the book: '
    title = gets.chomp
    print 'Enter the author of the book: '
    author = gets.chomp

    book = Book.new(title, author)
    @books << book
    save
    puts "Book '#{book.title}' by #{book.author} created."
  end

  def find(&block)
    @books.find(&block)
  end
end
