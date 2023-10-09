require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'action_interface'

class Rentals < ActionInterface
  def initialize(rentals)
    @rentals = rentals
    super()
  end

  def create(books, people)
    people.list_all
    print 'Enter the ID of the person who is renting a book: '
    person_id = gets.chomp.to_i
    person = people.find { |p| p.id == person_id }

    books.list_all
    print 'Enter the ID of the book being rented: '
    book_id = gets.chomp.to_i
    book = books.find { |b| b.id == book_id }

    print 'Enter the rental date (YYYY-MM-DD): '
    date = gets.chomp

    existing_rental = @rentals.find { |r| r.date == rental.date }
    rental = Rental.new(date, person, book)
    @rentals << rental unless existing_rental
    puts "Rental created for #{person.name}: #{book.title} on #{date}." unless existing_rental
    puts "Duplicate! unable to create rental for: #{book.title} on #{date}." if existing_rental
  end

  def list_all(people)
    if @rentals.empty?
      puts 'No rentals at the moment.'
    else
      people.list_all
      print 'Enter the ID of the person to list their rentals: '
      person_id = gets.chomp.to_i
      person = people.find { |p| p.id == person_id }

      puts "Rentals for #{person.name}:"
      rentals = @rentals.select { |r| r.person == person }
      rentals.each do |rental|
        puts "#{rental.book.title} by #{rental.book.author}, rented on #{rental.date}"
      end
    end
  end
end
