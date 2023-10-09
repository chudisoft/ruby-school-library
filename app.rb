require_relative 'persons'
require_relative 'rentals'
require_relative 'books'

class App
  def initialize
    @books = Books.new([])
    @rentals = Rentals.new([])
    @people = Persons.new([])
  end

  def list_books
    @books.list_all
  end

  def list_people
    @people.list_all
  end

  def create_person
    @people.create
  end

  def create_book
    @books.create
  end

  def create_rental
    @rentals.create(@books, @people)
  end

  def list_rentals_for_person
    @rentals.list_all(@people)
  end
end
