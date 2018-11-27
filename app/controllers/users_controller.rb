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
    flash[:errors] = "Invalid credentials.  Please try again or sign up."
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
    if params[:email] == User.find_by(email: params[:email]).email
      flash[:errors] = "Could not create new account: There is already a user with that email address"
      redirect '/signup'
    else
      if @user.save
        session[:user_id] = @user.id
        flash[:message] = "Account created. Welcome, #{@user.username}!"
        redirect "/users/#{@user.id}"
      else
        flash[:errors] = "Could not create new account: #{@user.errors.full_messages.to_sentence}"
        redirect '/signup'
      end
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
