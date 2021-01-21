
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect "/articles"
  end

  get('/articles') {
    @articles = Article.all
    puts @articles
    erb :index
  }

  post('/articles') {
    article = Article.create(params)
    redirect "/articles/#{article.id}"
  }

  get('/articles/new') {
    erb :new
  }

  patch('/articles/:id') {
    article = Article.find(params['id'])
    article.title = params['title']
    article.content = params['content']
    article.save
    redirect "/articles/#{article.id}"
  }

  get('/articles/:id') {
    @article = Article.find(params[:id]) 
    erb :show
  }

  get('/articles/:id/edit') {
    @article = Article.find(params[:id])
    erb :edit
  }

  delete('/articles/:id') {
    Article.destroy(params[:id])
    redirect "/articles"
  }
end
