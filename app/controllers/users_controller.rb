class UsersController < ApplicationController
  get '/login' do
    if logged_in?
      redirect "/plants"
    else
      erb :login
    end
  end

  post '/login' do
  @user = User.find_by(email: params[:email])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    flash[:message] = "Welcome, #{@user.username}!"
    redirect "/plants"
  else
    flash[:errors] = "Invalid credentials.  Please try again or sign up."
    redirect '/login'
  end
end

  get '/signup' do
    if logged_in?
      redirect "/plants"
    else
      erb :signup
    end
  end

  post '/users' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "Account created. Welcome, #{@user.username}!"
      redirect "/plants"
    else
      flash[:errors] = "Could not create new account: #{@user.errors.full_messages.to_sentence}"
      redirect '/signup'
    end
  end

  # get '/users' do #All users index page
  #   @users = User.all
  #   erb :'/users/index'
  # end


  # get '/users/:id' do
  #   @user = User.find_by(id: params[:id])
  #   erb :'/users/show'
  # end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
