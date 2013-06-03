require "sinatra"

require "active_record"
require "sinatra/activerecord"
require './models/user'
require './models/planet'
require './models/own'
require './space'
require './ship'

require "./components/component"
require "./components/engine"
require "./components/generator"
require "./components/shield"
require "./components/weopon"
require "./components/sensor"



enable :sessions

set :database, 'sqlite3://development.sqlite3.db'

configure do
  ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => 'db/development.sqlite3')
end

$space = Space.new

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
    engine = Engine.new("Mass Drive",5,5)
    generator = Generator.new("Mass gen",5)
    shield = Shield.new("Shield 3",5,50,5)
    weopons = Weopon.new("Mass Driver",5,5,5,5)
    sensor = Sensor.new("TestSensor",10,100)

    ship = Ship.new(user.name,100,1,engine,generator,sensor,shield,weopons)
    $space.addShip(rand(60),rand(60),rand(60),ship)
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
    erb :login
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

post "/command" do
  ship=$space.find_player(session[:user])
  ship.command(params[:commando].split)
end



