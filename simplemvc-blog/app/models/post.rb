class Post
  attr_accessor :id, :title, :body, :created_at

  def initialize
    @id = nil
    @title = ""
    @body = ""
    @created_at = nil
  end
end
