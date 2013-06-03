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

helpers do
  def logged_in?
    if session[:user]
      true
    else
      false
    end
  end
  
  #Flash helper based on the one from here:
  #https://github.com/daddz/sinatra-dm-login/blob/master/helpers/sinatra.rb
def show_flash(key)
  if session[key]
    flash = session[key]
    session[key] = false
    flash
    end
  end
end

get "/" do
  session["user"] ||= nil
  erb :index
end

get "/login" do
  erb :login
  #TODO handle login and redirect to ui
end

post "/login" do
  user = User.where(:name => params[:name]).first
  
  if !user
    session[:flash] = "User doesn't exist"
    redirect "/"
  end
  
  authenticated = user.authenticate(params[:password])
  
  if authenticated
    session[:user] = user.name
  else
    return "Incorrect Password"
  end
  
  redirect "/ui"
end

get "/register" do
  erb :register
end

post "/register" do
  user = User.new
  user.name = params[:name]
  user.password = params[:password]
  if user.save
    "Succes!"
  end
end

post "/logout" do
  session[:user] = nil
  session[:flash] = "Logged out"
  redirect "/"
end

get "/ui" do
  if session[:user]
    @user = User.where(:name => session[:user]).first
    erb :ui
  else
    redirect "/"
  end
end
