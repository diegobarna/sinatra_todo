require 'yaml'
require 'yaml/store'
require 'sinatra'

class Task
  attr_reader :content, :id, :completed, :created_at, :updated_at
  
  @@current_id = 1

  def initialize(content)
    @content = content
    @id = @@current_id
    @created_at = Time.now
    @updated_at = nil
    @completed = false
    @@current_id += 1
  end
  
  def complete?
    @completed
  end

  def complete!
    @completed = true
  end

  def incomplete!
    @completed = false
  end

  def update_content!(new_content)
    @content = new_content
    @updated_at = Time.now
  end
end

class TodoList
  attr_reader :tasks, :username

  def initialize(username="User")
    @tasks = []
    @username = username
    @todo_store = YAML::Store.new("./public/tasks.yml")
  end

  def add_task(task)
    @tasks << task
  end

  def delete_task(id)
    @tasks.delete_if { |task| task.id == id }
  end

  def find_task_by_id(id)
    @tasks.find{ |task| task.id == id }
  end

  def sort_by_created(order)
    case order
    when "ASC"
      @tasks.sort{ |task1, task2| task1.created_at <=> task2.created_at }
    when "DESC"
      @tasks.sort{ |task1, task2| task2.created_at <=> task1.created_at }
    else
      nil
    end
  end

  def save
    @todo_store.transaction do 
      @todo_store[@username] = @tasks
    end
  end

end