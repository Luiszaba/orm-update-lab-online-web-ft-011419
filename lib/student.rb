require_relative "../config/environment.rb"

class Student
  
  attr_accessor :name, :grade
  attr_reader :id


def initialize(id = nil, name, grade)
  @name = name
  @grade = grade
  @id = id
end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

def self.create_table
  sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade INTEGER
    )
    SQL
    DB[:conn].execute(sql)
  end
  
def self.drop_table
  sql =<<-SQL
  DROP TABLE IF EXISTS students
  SQL
  DB[:conn].execute(sql)
end

def self.create(classmate)
  classmate = Student.new(name, grade)
  classmate.save
  classmate
end

def self.save
  
if self.id
   self.update
else
  sql = <<-SQL
  INSERT INTO students 
  VALUES (?, ?)
  SQL
  DB[:conn].execute(sql, self.name, self.grade)
  @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
end

end

end


