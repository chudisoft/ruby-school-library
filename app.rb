require_relative 'persons'
require_relative 'rentals'
require_relative 'books'

class App
  attr_accessor :actions

  def initialize
    @books = Books.new([])
    @rentals = Rentals.new([])
    @people = Persons.new([])
    @actions = [
      -> { @books.list_all }, -> { @people.list_all },
      -> { @people.create }, -> { @books.create },
      -> { @rentals.create(@books, @people) },
      -> { @rentals.list_all(@people) }
    ]
  end
end
