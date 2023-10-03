require_relative 'person'
require_relative 'student'
require_relative 'teacher'

# Create instances of Person, Student, and Teacher
person = Person.new(25, 'John', false)
student = Student.new(17, 'Math', 'Alice', true)
student_b = Student.new(17, 'Math', 'Chudisoft', false)
teacher = Teacher.new(30, 'History', 'Mr. Smith')

# Test can_use_services? method
puts "#{person.name} can use services: #{person.can_use_services?}" # Should be true (age >= 18)
puts "#{student.name} can use services: #{student.can_use_services?}" # Should be true (parent permission)
puts "#{student_b.name} can use services: #{student_b.can_use_services?}" # Should be false (parent permission)
puts "#{teacher.name} can use services: #{teacher.can_use_services?}" # Should be true (overridden method)

# Test play_hooky? method
puts "#{student.name} play_hooky: #{student.play_hooky}"
