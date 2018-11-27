class UsersController < ApplicationController
  get '/login' do
    erb :login
  end

  post '/login' do
  @user = User.find_by(email: params[:email])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    flash[:message] = "Welcome, #{@user.name}!"
    redirect "users/#{@user.id}"
  else
    flash[:errors] = "Your credentials were invalid.  Please sign up or try again."
    redirect '/login'
  end
end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    @user = User.new(params[:username], params[:email], params[:password_digest])
    redirect '/users'
  end
end
