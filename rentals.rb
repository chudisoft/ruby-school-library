require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'action_interface'
require_relative 'persons_module'
require 'json'

class Rentals < ActionInterface
  include PersonsModule
  def initialize()
    @rentals = read_rentals_from_json_file
    super()
  end

  def read_rentals_from_json_file()
    file_path = 'rentals.json'
    rentals = []
    return rentals unless File.exist?(file_path)

    begin
      # Read the JSON file
      json_data = File.read(file_path)

      # Parse the JSON data into an array of hashes
      rental_hashes = JSON.parse(json_data)

      # Create Book objects from each hash and add them to the array
      rental_hashes.each do |hash|
        book = Book.new(hash['book']['title'], hash['book']['author'])
        person = get_person(hash['person'])
        rental = Rental.new(hash['date'], book, person)
        rentals << rental
      end
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end

    rentals
  end

  def save
    rentals_hashes = @rentals.map(&:to_hash)
    rentals_json = JSON.pretty_generate(rentals_hashes)
    File.write('rentals.json', rentals_json)
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
    save unless existing_rental
    puts existing_rental ? "Duplicate! unable to create rental for: #{book.title} on #{date}." : "Rental created for #{person.name}: #{book.title} on #{date}."
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
