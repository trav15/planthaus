class UsersController < ApplicationController
  get '/login' do
    erb :login
  end

  get '/signup' do
    erb :signup
  end

  post '/users' do
    @user = User.new(params[:username], params[:email], params[:password_digest])
    redirect '/users'
  end
end
