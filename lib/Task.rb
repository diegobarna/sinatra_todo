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

  def show_content
    @content
  end
end