require 'pry'
class FiguresController < ApplicationController
  
  get '/figures/new'  do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.new(name: params[:figure][:name])
    @figure.landmark_ids = params[:figure][:landmark_ids]
    if params[:landmark][:name].empty? == false
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end
    @figure.title_ids = params[:figure][:title_ids]
    if params[:title][:name].empty? == false
      @figure.titles << Title.create(name: params[:title][:name])
    end
    @figure.save
    redirect '/figures'
  end

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.name = params[:figure][:name]
    if params[:landmark][:name].empty? == false
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end
    @figure.title_ids = params[:figure][:title_ids]
    if params[:title][:name].empty? == false
      @figure.titles << Title.create(name: params[:title][:name])
    end
    @figure.save
    redirect "figures/#{@figure.id}"
  end

end