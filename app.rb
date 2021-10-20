require "sinatra/base"
require "sinatra/reloader"
require './lib/user'
require './lib/room'

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

    redirect '/rooms'
  end

  get "/rooms" do
    @username = session[:user].name
    @rooms = Room.all
    erb :'rooms'
  end

  get '/rooms/new' do
    erb :'rooms/new'
  end

  post '/rooms/new' do
    Room.add(user_id: session[:user].id, title: params[:title], description: params[:description], price: params[:price], location: params[:location])
    redirect '/rooms'
  end
#user_id:, room_id:, occupied_date:
  post '/rooms/request' do
    @user_id = session[:user].id
    title = params[:title]
    
    Rented_rooms.request_room(user_id: session[:user].id, room_id: params[:room_id], occupied_date:)
  end

  run! if app_file == $0
end
