require './todo'

describe Task do
  before :each do
    @task = Task.new("Buy th milk")
  end

  describe "#new" do
    it "creates task with id 1" do
      expect(@task.id).to be 1
      expect(@task.created_at.strftime("%I:%M")).to eq Time.now.strftime("%I:%M")
      expect(@task.updated_at).to be nil
    end
  end

  describe "#complete?" do
    it "ask if task is completed" do
      expect(@task.complete?).to be false
    end
  end

  describe "#complete!" do
    it "completes the task" do
      expect(@task.complete!).to be true
    end
  end

  describe "#incomplete!" do
    it "makes task incomplete" do
      expect(@task.incomplete!).to be false
    end
  end

  describe "#update_content!" do
    it "updates the task content" do
      @task.update_content!("Walk the dog")
      expect(@task.content).to eq "Walk the dog"
      expect(@task.updated_at).to be > @task.created_at
    end
  end
end



describe TodoList do
  before :each do
    @todo_list = TodoList.new("Diego")
    task1 = Task.new("Walk the dog")
    task2 = Task.new("Buy the milk")
    task3 = Task.new("Feed the fish")
    @todo_list.add_task(task1)
    @todo_list.add_task(task2)
    @todo_list.add_task(task3)
    @todo_list.save
  end

  describe "#new" do
    it "creates an empty tasks list with user name Diego" do
      todo_list = TodoList.new("Diego")
      expect(todo_list.tasks).to be_empty
      expect(todo_list.username).to eq "Diego"
    end
    it "creates an empty tasks list with default user name" do
      todo_list = TodoList.new
      expect(todo_list.username).to eq "User"
    end
  end

  describe "#add_task" do
    it "adds a task to the list" do
      previous_tasks = @todo_list.tasks.size
      @todo_list.add_task(Task.new("Feed the fish"))
      expect(@todo_list.tasks.size).to be > previous_tasks
    end
  end

  describe "#delete_task" do
    it "deletes a task by its id" do
      id = @todo_list.tasks.first.id
      previous_tasks = @todo_list.tasks.size
      @todo_list.delete_task(id)
      expect(@todo_list.tasks.size).to be < previous_tasks
    end
  end

  describe "#find_task_by_id" do
    it "finds the task by its id" do
      id = @todo_list.tasks.first.id
      task = @todo_list.find_task_by_id(id)
      expect(task.id).to eq id
    end
    it "returns nil if does not find the id" do
      id = @todo_list.tasks.last.id + 1
      expect(@todo_list.find_task_by_id(id)).to be_nil
    end
  end

  describe "#sort_by_created" do
    it "sorts tasks by created time ascending" do
      asc_todo_list = @todo_list.sort_by_created("ASC")
      first_task = asc_todo_list.first
      last_task = asc_todo_list.last
      expect(first_task.created_at).to be < last_task.created_at
    end
    it "sorts tasks by created time descending" do
      asc_todo_list = @todo_list.sort_by_created("DESC")
      first_task = asc_todo_list.first
      last_task = asc_todo_list.last
      expect(first_task.created_at).to be > last_task.created_at
    end
  end

end



