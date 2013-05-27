require "sinatra"

require "active_record"
require "sinatra/activerecord"
require './models/user'
require './models/planet'
require './models/own'


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

get "/login" do
  erb :login
  #TODO handle login and redirect to ui
end

get "/ui" do
  #TODO user handling
  erb :ui
end
