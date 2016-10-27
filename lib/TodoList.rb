class TodoList
  attr_reader :tasks, :username

  def initialize(username)
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

  def delete_task(id)
    @tasks.delete_if{|task| task.id == id}
  end

  def save
    @todo_store.transaction do 
      @todo_store[@username] = @tasks
    end
  end

  def load_tasks
    todo_load = YAML::load( File.open("./public/tasks.yml") )
    @tasks = todo_load[@username]
  end

end
