require_relative 'person'

class Teacher < Person
  def initialize(specialization, age, name: 'Unknown', id: 0)
    super(age, name: name, id: id)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
