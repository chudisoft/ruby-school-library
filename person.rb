class Person
  attr_reader :id
  attr_accessor :name, :age

  def initialize(age, name = 'Unknown', parent_permission = true)
    @id = generate_id
    @name = name
    @age = age.to_i
    @parent_permission = parent_permission
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  private

  def of_age?
    @age >= 18
  end

  def generate_id
    rand(10_000..99_999)
  end
end
