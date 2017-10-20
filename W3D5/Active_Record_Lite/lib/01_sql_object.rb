require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    data = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    data.first.map!(&:to_sym)
    @columns = data.first
  end

  def self.finalize!
    columns.each do |name|
      define_method(name) {self.attributes[name]}
      define_method("#{name}=") { |val| self.attributes[name] = val }      
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.name.tableize
  end

  def self.all
    data = DBConnection.instance.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL
    parse_all(data)
  end

  def self.parse_all(results)
    results.map {|val| self.new(val) }
  end

  def self.find(id)
    # byebug
    data = DBConnection.instance.execute(<<-SQL)
    SELECT
      #{table_name}.*
    FROM
      #{table_name}
    WHERE
      #{table_name}.id = #{id}
    SQL
    parse_all(data).first
  end

  def initialize(params = {})
    columns = self.class.columns
    params.each do |key, val|
      attr_name = key.to_sym
      raise "unknown attribute '#{attr_name}'" if !columns.include?(attr_name)
      self.send("#{key}=", val)
    end
  end

  def attributes
    # ...
    @attributes = {} unless @attributes
    @attributes
  end

  def attribute_values
    self.class.columns.map {|col| self.send(col)}
  end

  def insert
    cols = self.class.columns.drop(1)
    col_names = cols.map(&:to_s).join(", ") 

    question_marks_arr = []
    (cols.length).times do 
      question_marks_arr << "?"
    end

    values = attribute_values
    question_marks = question_marks_arr.join(",")

    data = DBConnection.instance.execute(<<-SQL, *values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.send("id=", DBConnection.instance.last_insert_row_id)
  end

  def update
    cols = self.class.columns.drop(1)
    cols_set = cols.map { |el| "#{el} = ?"}.join(', ')
    values = attribute_values
    id = values.first
    data = DBConnection.instance.execute(<<-SQL, *values.drop(1), id)
      UPDATE
        #{self.class.table_name}
      SET
        #{cols_set}
      WHERE
        id = ?
    SQL
  end

  def save
    id.nil? ? insert : update
  end
end

class Human < SQLObject
  self.table_name = 'humans'

  self.finalize!
end

h = Human.find(1)

puts h.id