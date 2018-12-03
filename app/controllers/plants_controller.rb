class PlantsController < ApplicationController
  get '/plants' do
    if logged_in?
      @user = current_user
      erb :'plants/index'
    else
      redirect to '/login'
    end
  end

  get '/plants/new' do
    if logged_in?
      erb :'plants/new'
    else
      redirect to '/login'
    end
  end

  post '/plants' do
    if logged_in?
      if params[:content] == ""
        redirect to "/plants/new"
      else
        @plant = current_user.plants.new(params)
        if @plant.save
          flash[:message] = "New plant added to your family!"
          redirect to "/plants/#{@plant.id}"
        else
          flash[:errors] = "Unable to add plant: #{@plant.errors.full_messages.to_sentence}. Please try again."
          redirect to "/plants/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/plants/:id' do
    if logged_in?
      @plant = Plant.find_by_id(params[:id])
      if authorized_to_edit?(@plant)
        erb :'plants/show'
      else
        flash[:errors] = "You do not have permission to view this plant."
        redirect "/plants"
      end
    else
      redirect to '/login'
    end
  end

  get '/plants/:id/edit' do
    redirect_if_not_logged_in
    @plant = Plant.find(params[:id])
    if authorized_to_edit?(@plant)
      erb :'/plants/edit'
    else
      flash[:errors] = "You do not have permission to edit this plant."
      redirect "/plants"
    end
  end

  patch '/plants/:id' do
    redirect_if_not_logged_in
    @plant = Plant.find(params[:id])
    if authorized_to_edit?(@plant) && params[:name] != ""
      @plant.update(name: params[:name], scientific_name: params[:scientific_name], plant_type: params[:plant_type], light_requirement: params[:light_requirement], water_requirement: params[:water_requirement], date_purchased: params[:date_purchased], notes: params[:notes])
      flash[:message] = "Plant information updated!"
      redirect "/plants/#{@plant.id}"
    else
      flash[:errors] = "You do not have permission to edit this plant."
      redirect "/plants"
    end
  end

  get '/plants/:id/delete' do
    redirect_if_not_logged_in
    @plant = Plant.find(params[:id])
    if authorized_to_edit?(@plant)
      erb :'/plants/delete'
    else
      flash[:errors] = "You do not have permission to edit this plant."
      redirect "/plants"
    end
  end

  delete '/plants/:id/delete' do
    @plant = Plant.find(params[:id])
    if authorized_to_edit?(@plant)
      @plant.delete
      flash[:message] = "Plant has been removed."
      redirect '/plants'
    else
      redirect '/plants'
    end
  end
end
