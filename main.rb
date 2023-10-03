require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'

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