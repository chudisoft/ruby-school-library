class Book
  attr_accessor :title, :author
  attr_reader :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    existing_rental = @rentals.find { |r| r.date == rental.date }
    @rentals << rental unless existing_rental
  end
end
