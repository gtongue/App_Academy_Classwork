class Employee
  attr_reader :salary

  def initialize(name, salary, title, boss)
    @name = name
    @salary = salary
    @title = title
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end


end

class Manager < Employee
  attr_accessor :sub_employees
  
  def initialize(name, salary, title, boss)
    super
    @sub_employees = []
  end


  def bonus(multiplier)
    sum = 0
    @sub_employees.each { |emp| sum += emp.salary }
    sum * multiplier
  end
end
