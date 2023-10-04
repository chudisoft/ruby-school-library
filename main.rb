require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'
require_relative 'rental'
require_relative 'book'
require_relative 'classroom'

# Create instances of Person, Student, and Teacher
person = Person.new(25, name: 'John', parent_permission: false)
student = Student.new('Math', 17, name: 'Alice', parent_permission: true)
student_b = Student.new('Math', 17, name: 'Erick', parent_permission: false)
student_b.name = 'Chudisoft'
teacher = Teacher.new('History', 30, name: 'Mr. Smith')

# Test can_use_services? method
puts "#{person.name} can use services: #{person.can_use_services?}" # Should be true (age >= 18)
puts "#{student.name} can use services: #{student.can_use_services?}" # Should be true (parent permission)
puts "#{student_b.name} can use services: #{student_b.can_use_services?}" # Should be false (parent permission)
puts "#{teacher.name} can use services: #{teacher.can_use_services?}" # Should be true (overridden method)

# Test play_hooky? method
puts "#{student.name} play_hooky: #{student.play_hooky}"

# Test the decorators
person = Person.new(22, name: 'maximilianus')
puts "Original Name: #{person.correct_name}"

capitalized_person = CapitalizeDecorator.new(person)
puts "Capitalized Name: #{capitalized_person.correct_name}"

capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts "Capitalized and Trimmed Name: #{capitalized_trimmed_person.correct_name}"

# Test Associations
# Create a Classroom
classroom = Classroom.new('Math Class')
classroom.add_student(student)
classroom.add_student(student_b)

# Print the Classroom label and its students
puts "Classroom Label: #{classroom.label}"
puts 'Students in Classroom:'
classroom.students.each do |s|
  puts "- #{s.name}"
end

# Create Books
book1 = Book.new('Book 1', 'Author 1')
book2 = Book.new('Book 2', 'Author 2')

# Create more persons
person2 = Person.new(25, name: 'Jane', parent_permission: true)

# Create Rentals and associate Books and People
Rental.new('2023-10-01', person, book1)
Rental.new('2023-10-02', person, book2)
Rental.new('2023-10-03', person2, book1)
Rental.new('2023-10-03', person2, book1)

# Print People and their Rentals
puts "\nPeople and their Rentals:"
[person, person2].each do |p|
  puts "#{p.name}'s Rentals:"
  p.rentals.each do |rental|
    puts "- #{rental.book.title} by #{rental.book.author}, Date: #{rental.date}"
  end
end

# Print Books and their Rentals
puts "\nBooks and their Rentals:"
[book1, book2].each do |b|
  puts "#{b.title}'s Rentals:"
  b.rentals.each do |rental|
    puts "- by #{rental.person.id} #{rental.person.name}, Date: #{rental.date}"
  end
end
