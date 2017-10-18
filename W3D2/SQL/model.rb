require 'active_support/inflector'
require_relative 'questions_database'
require 'byebug'

class Model
  def initialize(options); end
  def self.table
    self.to_s.tableize
  end

  def self.find_by_id(id)
    options = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table}
      WHERE
        id = ?
    SQL
    self.new(options.first)
  end

  def self.all
    QuestionsDatabase.instance.execute("SELECT * FROM #{table}")
  end

  def save
    instance_vars = self.instance_variables.rotate
    instance_vars_strings = instance_vars.map{|l| l.to_s}
    instance_var_settings = instance_vars.map{|el| el[1..-1] + "=?"}.join(',')
    question_marks = []
    (instance_vars.length-1).times {question_marks << '?'}
    question_marks_string = question_marks.join(',')
    table = self.class.table
    if @id
      QuestionsDatabase.instance.execute(<<-SQL, *instance_vars.values)
        UPDATE
          #{table}
          -- #{p instance_vars}
        SET
          #{instance_var_settings}
        WHERE
          id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, instance_vars_strings)
        INSERT INTO
          #{table}(title, body, user_id)
        VALUES
          (#{question_marks_string})
      SQL
    end
  end


end
