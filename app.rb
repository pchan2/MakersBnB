require "sinatra/base"
require "sinatra/reloader"

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get "/signin" do
    erb :'signin'
  end

  post "/signin-submit" do
    session[:username] = params[:username]
    redirect '/rooms'
  end

  get "/rooms" do
    @username = session[:username]
    erb :'rooms'
  end

  run! if app_file == $0
end
