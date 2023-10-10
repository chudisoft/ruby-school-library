class Person
  attr_reader :id, :rentals
  attr_accessor :name, :age

  def initialize(age, name: 'Unknown', parent_permission: true, id: 0)
    @id = id <= 0 ? Random.rand(1..1000) : id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def to_hash
    if instance_of?(Student)
      { 'class' => self.class, 'classroom' => @classroom, 'age' => @age, 'name' => @name,
        'parent_permission' => @parent_permission, id: @id }
    else
      { 'class' => self.class, 'specialization' => @specialization, 'age' => @age, 'name' => @name,
        'parent_permission' => @parent_permission, id: @id }
    end
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  private

  def of_age?
    @age.to_i >= 18
  end

  def generate_id
    rand(10_000..99_999)
  end
end
