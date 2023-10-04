class Book
  attr_accessor :title, :author
  attr_reader :id, :rentals

  def initialize(title, author)
    @id = rand(10_000..99_999)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    existing_rental = @rentals.find { |r| r.date == rental.date }
    @rentals << rental unless existing_rental
  end
end
