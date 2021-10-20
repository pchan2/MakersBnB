require "sinatra/base"
require "sinatra/reloader"
require "./lib/user"
require "./lib/room"
require_relative "./lib/rented_rooms.rb"
require "pg"

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get "/signin" do
    erb :'signin'
  end

  post "/signin-submit" do
    user = User.add(name: params[:username])
    session[:user] = user

    redirect "/rooms"
  end

  get "/rooms" do
    @username = session[:user].name
    @rooms = Room.all
    erb :'rooms'
  end

  get "/rooms/new" do
    erb :'rooms/new'
  end

  post "/rooms/new" do
    Room.add(user_id: session[:user].id, title: params[:title], description: params[:description], price: params[:price], location: params[:location])
    redirect "/rooms"
  end

  post "/rooms/request" do
    # @user_id = session[:user].id
    title = params[:title]
    if ENV["RACK_ENV"] == "test"
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: "makersbnb")
    end
    # connection = PG.connect(dbname: "makersbnb")
    p "hello"
    result = connection.query("SELECT id FROM rooms WHERE title = '#{title}';")
    room_id = result[0]["id"].to_i
    session[:your_requests] = Rented_rooms.request_room(user_id: session[:user].id, room_id: room_id, occupied_date: params[:occupied_date])
    redirect "/rooms/your_requests"
  end

  get "/rooms/your_requests" do
    p @your_request = session[:your_requests].occupied_date
    erb :'rooms/your_requests'
  end

  run! if app_file == $0
end
