require "sinatra/base"
require "sinatra/reloader"
require "./lib/user"
require "./lib/room"
require_relative "./lib/rented_rooms.rb"
require "pg"
require './spec/database_helpers'

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
    title = params[:title]
    connection = database_switcher

    result = connection.query("SELECT id FROM rooms WHERE title = '#{title}';")
    room_id = result[0]["id"].to_i
    session[:your_requests] = Rented_rooms.request_room(user_id: session[:user].id, room_id: room_id, occupied_date: params[:occupied_date])
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

  get '/approvals' do
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    @result = connection.query("SELECT rented_rooms.id, rooms.title, rooms.description, rooms.price, rooms.location, rented_rooms.occupied_date FROM users, rooms, rented_rooms WHERE users.id = '#{session[:user].id}' AND users.id = rooms.user_id AND rented_rooms.room_id = rooms.id")
    
    erb :'/approvals'
  end

  post '/approvals' do
    Rented_rooms.approve_request(id: params[:id], approval: params['approved']=="approve")
    redirect '/approvals'
  end

  run! if app_file == $0
end
