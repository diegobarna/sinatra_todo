require './todo'

describe Task do
  before :each do
    @task = Task.new("Buy milk")
  end

  describe "#new" do
    it "creates task with id 1" do
      expect(@task.id).to be 1
      expect(@task.created_at.strftime("%I:%M")).to eq Time.now.strftime("%I:%M")
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

end
