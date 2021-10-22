require "sinatra/base"
require "sinatra/reloader"
require "./lib/user"
require "./lib/room"
require_relative "./lib/rented_rooms.rb"
require './spec/database_helpers'


class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get "/" do
    erb :'new_user'
  end

  post "/new_user_submit" do
    user = User.add(name: params[:username], password: params["password"])
    session[:user] = user
    redirect "/rooms"
  end

  get "/signin" do
    if session[:user] == false
      @Reply = "Account not recognised"
    end
    erb :'signin'
  end

  post "/signin-submit" do
    id = User.signin(name: params[:username], password: params[:password])
    if id == nil
      session[:user] = false
      redirect "/signin"
    else
      user = User.new(id: id, name: params[:username])
      session[:user] = user
      redirect "/rooms"
    end
  end

  get "/rooms" do
    @username = session[:user].name
    @rooms = Room.all
    erb :'rooms'
  end

  post "/rooms" do
    session[:desired_date] = params[:desired_date]
    redirect '/rooms/filtered_date'
  end

  get '/rooms/filtered_date' do
    @desired_date = session[:desired_date]
    @filtered_rooms = Room.available_rooms(@desired_date)
    
    erb :'/rooms/filtered_date'
  end

  get "/rooms/new" do
    erb :'rooms/new'
  end

  post "/rooms/new" do
    Room.add(user_id: session[:user].id, title: params[:title], description: params[:description], price: params[:price], location: params[:location], available_from: params[:available_from], available_to: params[:available_to])
    redirect "/rooms"
  end

  post "/rooms/request" do
    connection = database_switcher
    session[:your_requests] = Rented_rooms.request_room(user_id: session[:user].id, room_id: params[:id].to_i, occupied_date: session[:desired_date])
    redirect "/rooms/your_requests"
  end

  get "/rooms/your_requests" do
    @occupied_date = session[:your_requests].occupied_date
    @room_id = session[:your_requests].room_id
    @username = session[:user].name
    @approve_status = session[:your_requests].approved

    connection = database_switcher
    result = connection.query("SELECT * FROM rooms WHERE id = '#{@room_id}';")

    @room_details = result[0]
    erb :'rooms/your_requests'
  end

  get "/approvals" do
    connection = database_switcher
    @result = connection.query("SELECT rented_rooms.id, rooms.title, rooms.description, rooms.price, rooms.location, rented_rooms.occupied_date FROM users, rooms, rented_rooms WHERE users.id = '#{session[:user].id}' AND users.id = rooms.user_id AND rented_rooms.room_id = rooms.id AND rented_rooms.approved = 'f'")

    erb :'/approvals'
  end

  post "/approvals" do
    Rented_rooms.approve_request(id: params[:id], approval: params["approved"] == "approve")
    redirect "/approvals"
  end

  run! if app_file == $0
end
