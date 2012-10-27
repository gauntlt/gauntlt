require 'rubygems'
require 'sinatra/base'

if RUBY_PLATFORM == 'java'
  require 'jdbc/sqlite3'
  require 'java'
  org.sqlite.JDBC

  $DB = java.sql.DriverManager.getConnection("jdbc:sqlite:goat.db")
  $statement = $DB.createStatement

  def db_exec(sql)
    $statement.execute(sql)
  end
else
  require 'sqlite3'
  $DB = SQLite3::Database.new "goat.$DB"
  def db_exec(sql)
    $DB.execute(sql)
  end
end



# Create a database
rows = db_exec <<-SQL
create table if not exists numbers (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name varchar(30),
  val int
);
SQL

# Execute a few inserts
{
  "one" => 1,
  "two" => 2,
}.each do |name, value|
  db_exec "insert into numbers(id, name, val) values ( NULL, '#{name}', '#{value}' )"
end

module Gauntlt
end

class Gauntlt::Scapegoat < Sinatra::Base
  helpers do
    def page_title
    end
  end

  get '/' do
    erb :index
  end

  # sqlmap.py -u "http://localhost:9292/sql-injection?number_id=1"  --dbms sqlite
  get '/sql-injection' do
    query = if params['number_id']
              "select * from numbers where id = #{params['number_id']}"
            elsif params['sql']
              params['sql']
            end

    result = db_exec(query) if query

    erb :sqlmap, :locals => {:result => result}
  end

  get '/inline-js' do
    erb :inline_js
  end

  run! if app_file == $0
end