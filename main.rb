require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'
require_relative 'rental'
require_relative 'book'
require_relative 'classroom'

class Main
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def main
    puts 'Welcome to the Library Management System!'
    app = App.new(self)
    app.run
  end

  # Implement methods for listing books, people, creating people, creating books, creating rentals,
  # and listing rentals for a given person here.

  def list_books
    puts "List of Books (#{@books.length}):"
    @books.each do |book|
      puts "#{book.title} by #{book.author}"
    end
  end

  def list_people
    puts "List of People (#{@people.length}):"
    @people.each do |person|
      puts "#{person.name} (#{person.is_a?(Student) ? 'Student' : 'Teacher'})"
    end
  end

  def create_person
    print 'Enter the name of the person: '
    name = gets.chomp
    puts 'Choose the type of person:'
    puts '1. Student'
    puts '2. Teacher'
    print 'Enter the type (1 or 2): '
    type = gets.chomp.to_i

    if type == 1
      student = create_student(name)
      @people << student unless student.nil?
      puts "Student #{name} created."
    elsif type == 2
      teacher = create_teacher(name)
      @people << teacher unless teacher.nil?
      puts "Teacher #{name} created."
    else
      puts 'Invalid choice. No person created.'
    end
  end

  def create_student(name)
    print 'Enter the classroom of the person: '
    classroom = gets.chomp.to_str
    return nil unless classroom.length >= 1

    print 'Enter the student age (numeric): '
    age = gets.chomp.to_i
    return nil unless age.positive?

    puts 'Choose the type of parent permission (1 for true or 2 for false): '
    parent_permission = gets.chomp.to_i

    Student.new(classroom, age, name: name, parent_permission: parent_permission == 1)
  end

  def create_teacher(name)
    print 'Enter the specialization of the person: '
    specialization = gets.chomp
    return nil unless specialization.length >= 1

    print 'Enter the teacher\'s age (numeric): '
    age = gets.chomp.to_i
    return nil unless age.positive?

    puts 'Choose the type of parent permission (1 for true or 2 for false): '
    parent_permission = gets.chomp.to_i

    Teacher.new(specialization, age, name: name, parent_permission: parent_permission == 1)
  end

  def create_book
    print 'Enter the title of the book: '
    title = gets.chomp
    print 'Enter the author of the book: '
    author = gets.chomp

    book = Book.new(title, author)
    @books << book
    puts "Book '#{book.title}' by #{book.author} created."
  end

  def create_rental
    list_people
    print 'Enter the ID of the person who is renting a book: '
    person_id = gets.chomp.to_i
    person = @people.find { |p| p.object_id == person_id }

    list_books
    print 'Enter the ID of the book being rented: '
    book_id = gets.chomp.to_i
    book = @books.find { |b| b.object_id == book_id }

    print 'Enter the rental date (YYYY-MM-DD): '
    date = gets.chomp

    rental = Rental.new(date, person, book)
    @rentals << rental
    puts "Rental created for #{person.name}: #{book.title} on #{date}."
  end

  def list_rentals_for_person
    list_people
    print 'Enter the ID of the person to list their rentals: '
    person_id = gets.chomp.to_i
    person = @people.find { |p| p.object_id == person_id }

    puts "Rentals for #{person.name}:"
    rentals = @rentals.select { |r| r.person == person }
    rentals.each do |rental|
      puts "#{rental.book.title} by #{rental.book.author}, rented on #{rental.date}"
    end
  end
end

# main = Main.new
# main.main
