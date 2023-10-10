class Rental
  attr_accessor :date
  attr_reader :person, :book

  def initialize(date, person, book)
    @date = date
    @person = person
    @book = book
  end

  def to_hash
    {
      'date' => @date,
      'book' => @book.to_hash,
      'person' => @person.to_hash
    }
  end
end
