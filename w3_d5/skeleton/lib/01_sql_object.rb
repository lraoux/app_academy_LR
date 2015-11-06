require 'byebug'
require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  #why no question mark?
  def self.columns
    # ...
    columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name};
    SQL
    columns.first.map {|el| el.to_sym}
  end

  def self.finalize!
    columns.each do |column|
      define_method("#{column}=") do |val|
        attributes[column] = val
      end

      define_method("#{column}") do
        attributes[column]
      end
    end

  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    if @table_name
      @table_name
    else
      @table_name = self.to_s.tableize
    end
  end

  def self.all
    # ...
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    if results
      self.parse_all(results)
    else
      nil
    end
  end

  def self.parse_all(results)
    # ...
    arr = []
    results.each do |hash|
      arr << new(hash)
    end
    arr
  end

  def self.find(id)
    # ...
    object = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        id = ?
    SQL

    if object.empty? #arr is returned so it's never nil
      nil
    else
      new(object.first)
    end
  end

  def initialize(params = {})
    #why string interpolation for send?
    # ...
    params.each do |k,v|
      key = k.to_sym
      if !self.class.columns.include?(key)
        raise "unknown attribute '#{key}'"
      else
        send("#{k}=", v)
      end
    end
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
    self.class.columns.map {|el| self.send(el)}
  end

  def insert
    # ...
    # col_names = self.class.columns.join(",")
    # question_marks = (["?"]* col_names.length).join(",")
    # DBConnection.execute(<<-SQL, *attribute_values)
    #   INSERT INTO
    #     #{self.class.table_name} (#{col_names})
    #   VALUES
    #     (#{question_marks})
    #SQL
    columns = self.class.columns.drop(1)
    col_names = columns.map(&:to_s).join(", ")
    question_marks = (["?"] * columns.count).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})

    SQL
    self.id = DBConnection.last_insert_row_id

  end

  def update
    #why not worry about updating the id in attr_values?
    # ...
    columns = self.class.columns
    col_names = columns.map {|el| "#{el} = ?"}.join(", ")
    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{col_names}
      WHERE
        #{self.class.table_name}.id = ?
    SQL
  end

  def save
    # ...
    if id.nil?
      insert
    else
      update
    end
  end
end
