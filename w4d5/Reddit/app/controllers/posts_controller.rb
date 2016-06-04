class PostsController < ApplicationController

  before_action :is_author?, only: [:edit, :update]

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def new
    @post = Post.new
    # @sub_id = params[:sub_reddit_id]
    @subreddits = SubReddit.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      @subreddits = SubReddit.all
      flash[:errors] = ["POST NOT SAVED!! SORRY!!"]
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    # @sub_id = @post.sub_id
    @subreddits = SubReddit.all
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes!(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = ["CHANGES NOT SAVED!! SORRY!!"]
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to sub_reddit_url(post.subreddit)
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :author_id, sub_ids:[])
  end

  def is_author?
    redirect_to :back unless current_user.id == Post.find(params[:id]).author_id
  end
end
