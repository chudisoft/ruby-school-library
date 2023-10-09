require_relative 'student'
require_relative 'teacher'
require_relative 'action_interface'

class Persons < ActionInterface
  def initialize(people)
    @people = people
    super()
  end

  def list_all
    if @people.empty?
      puts 'People list is empty. Please try again and add people.'
    else
      puts "List of People (#{@people.length}):"
      @people.each do |person|
        puts "#{person.id} - #{person.name} (#{person.is_a?(Student) ? 'Student' : 'Teacher'})"
      end
    end
  end

  def create
    puts "Choose the type of person:\n1. Student\n2. Teacher"
    print 'Enter the type (1 or 2): '
    type = gets.chomp.to_i

    if type == 1
      student = create_student
      @people << student unless student.nil?
      puts "Student #{student.name} created."
    elsif type == 2
      teacher = create_teacher
      @people << teacher unless teacher.nil?
      puts "Teacher #{teacher.name} created."
    else
      puts 'Invalid choice. No person created.'
    end
  end

  def create_student()
    print 'Name: '
    name = gets.chomp
    print 'Classroom: '
    classroom = gets.chomp.to_str
    return nil unless classroom.length >= 1

    print 'Age (numeric): '
    age = gets.chomp.to_i
    return nil unless age.positive?

    print 'Parent permission (y for true or n for false): '
    parent_permission = gets.chomp

    Student.new(classroom, age, name: name, parent_permission: parent_permission.downcase == 'y')
  end

  def create_teacher()
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    return nil unless specialization.length >= 1

    print 'Age (numeric): '
    age = gets.chomp.to_i
    return nil unless age.positive?

    Teacher.new(specialization, age, name: name)
  end

  def find(&block)
    @people.find(&block)
  end
end
