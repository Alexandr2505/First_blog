class PostsController < ApplicationController
  
  before_action :set_post, only: [ :show, :edit, :update, :destroy]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 5)
  end




  def show
  end

  def new 
  	@post = Post.new
  end

  def create 
      @post = Post.new(post_params)
      if @post.save && @current_user != nil
    	  redirect_to @post, info: "Post was created"
      else
    	  render :new, danger: "Post was not created"
      end
  end

  def edit
  end

  def update
  	if @post.update_attributes(post_params)
  		redirect_to @post, info: "Post was updated"
  	else
  	  render :edit, danger: "Post was not updated"
    end 
  end

  def destroy
  	@post.destroy
  	redirect_to posts_path
  end

  private

    def post_params
    	params.require(:post).permit(:title, :summary, :body, :image, :all_tags)
    end

    def set_post
    	@post = Post.find(params[:id])
    end
end
