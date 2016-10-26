require 'yaml'
require 'yaml/store'
require 'sinatra'
require 'sinatra/reloader'
require './lib/Task'
require './lib/TodoList'
require './lib/UserAuth'
require 'pry'

enable :sessions

get '/' do
  todo_list = TodoList.new(session[:user])
  session[:tasks] = todo_list.load_tasks
  if session[:user].nil?
    erb :login
  else
    redirect to '/tasks'
  end
end

post '/login' do
  if UserAuth.valid?(params[:username], params[:password])
    session[:user] = params[:username]
    todo_list = TodoList.new(session[:user])
    session[:tasks] = todo_list.load_tasks
    redirect to '/tasks'
  else
    redirect to '/'
  end
end

get '/tasks' do
  binding.pry
  @tasks = session[:tasks]
  erb :tasks
end
