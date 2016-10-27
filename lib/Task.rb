class Task
  attr_reader :content, :id, :completed, :created_at, :updated_at
  
  def initialize(content, id)
    @content = content
    @id = id
    @created_at = Time.now
    @updated_at = nil
    @completed = false
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