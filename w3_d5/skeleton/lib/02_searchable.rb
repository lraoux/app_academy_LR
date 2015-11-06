require_relative 'db_connection'
require_relative '01_sql_object'
#why is table_name not self.class.table_name
module Searchable
  def where(params)
    # ...
    where_line = params.keys.map {|el| "#{el} = ?"}.join(" AND ")

  output = DBConnection.execute(<<-SQL, params.values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL
  parse_all(output)
  end
end

class SQLObject
  # Mixin Searchable here...
  #extend vs include
  extend Searchable
end
