class PostsController < Simplemvc::Controller
  def new
    @post = Post.new
  end

  def create
    post_params = params["post"]
    @post = Post.new
    @post.title = post_params["title"]
    @post.body = post_params["body"]
    @post.created_at = Time.now

    PostMapper.new.save(@post)
  end

  def index
    @posts = PostMapper.findAll
  end

  def edit
    @post = PostMapper.find(params["id"])
  end

  def update
    @post = PostMapper.find(params["id"])
    @post.title = params["post"]["title"]
    @post.body = params["post"]["body"]
    PostMapper.new.save(@post)
  end

  def delete
    PostMapper.new.delete(params["id"])
  end
end
