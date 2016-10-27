require 'yaml'
require 'yaml/store'
require 'sinatra'
require 'sinatra/reloader'
require './lib/Task'
require './lib/TodoList'
require './lib/UserAuth'
require 'pry'

enable :sessions

todo_list = TodoList.new("diego")
todo_list.load_tasks
current_id = todo_list.tasks.nil? ? 0 : todo_list.tasks.last.id

get '/' do
  if session[:user]
    redirect to '/tasks'
  else
    erb :login, :layout => false
  end
end

post '/login' do
  if UserAuth.valid?(params[:username], params[:password])
    session[:user] = params[:username]

    redirect to '/tasks'
  else
    redirect to '/'
  end
end

get '/tasks' do
  if session[:user]
    @tasks = todo_list.tasks
    erb :tasks
  else
    erb :login, :layout => false
  end
end

get '/new_task' do
  if session[:user]
    erb :new_task
  else
    erb :login, :layout => false
  end
end

post '/add_task' do
  current_id = current_id + 1
  todo_list.add_task(Task.new(params[:content], current_id))
  todo_list.save
  redirect to '/tasks'
end

get '/logout' do
  session[:user] = nil
  redirect to '/'
end

get '/complete/:id' do
  task = todo_list.find_task_by_id(params[:id].to_i)
  task.complete!
  todo_list.save
  redirect to '/tasks'
end

get '/incomplete/:id' do
  task = todo_list.find_task_by_id(params[:id].to_i)
  task.incomplete!
  todo_list.save
  redirect to '/tasks'
end

get '/delete/:id' do
  todo_list.delete_task(params[:id].to_i)
  todo_list.save
  redirect to '/tasks'
end
