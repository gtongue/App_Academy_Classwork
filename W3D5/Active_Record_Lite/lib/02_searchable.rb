require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    # ...
    p params
    where = params.keys.map { |key| "#{key} = ?"}.join(" AND ")
    data = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where}
    SQL
    parse_all(data)
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end