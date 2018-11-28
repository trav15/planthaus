class PlantsController < ApplicationController
  get '/plants' do
    @user = current_user
    erb :'plants/index'
  end
end
