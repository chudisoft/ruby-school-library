class Book
  attr_accessor :title, :author
  attr_reader :id, :rentals

  def initialize(title, author)
    @id = rand(10_000..99_999)
    @title = title
    @author = author
  end

  def to_hash
    { 'title' => @title, 'author' => @author }
  end
end
