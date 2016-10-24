class Task
  attr_reader :content, :id, :completed, :created_at
  
  @@current_id = 1

  def initialize(content)
    @content = content
    @id = @@current_id
    @created_at = Time.now
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
end