class UsersController < ApplicationController
  get '/login' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :login
    end
  end

  post '/login' do
  @user = User.find_by(email: params[:email])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    flash[:message] = "Welcome, #{@user.username}!"
    redirect "users/#{@user.id}"
  else
    flash[:errors] = "Your credentials were invalid.  Please sign up or try again."
    redirect '/login'
  end
end

  get '/signup' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :signup
    end
  end

  post '/users' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "You have successfully created an account, #{@user.username}!"
      redirect "/users/#{@user.id}"
    else
      flash[:errors] = "Account creation failure: #{@user.errors.full_messages.to_sentence}"
      redirect '/signup'
    end
  end

  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
