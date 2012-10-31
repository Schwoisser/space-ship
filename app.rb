require "sinatra"

require "active_record"
require "sinatra/activerecord"
require './models/user'
require './models/sector'
require './models/own'
require './models/attack'
require './models/article'

enable :sessions

set :database, 'sqlite3://development.sqlite3.db'

configure do
  ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => 'db/development.sqlite3')
end


get "/" do
  session["user"] ||= nil
  erb :index
end