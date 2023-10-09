require_relative 'book'
require_relative 'person'
require_relative 'action_interface'

class Books < ActionInterface
  def initialize(books)
    @books = books
    super()
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
    puts "Book '#{book.title}' by #{book.author} created."
  end
end
