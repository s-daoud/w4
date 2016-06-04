class SubRedditsController < ApplicationController

  before_action :is_mod?, only: [:edit, :update]

  def index
    @subreddits = SubReddit.all
    render :index
  end

  def show
    @subreddit = SubReddit.find(params[:id])
    render :show
  end

  def new
    @subreddit = SubReddit.new
    render :new
  end

  def create
    @subreddit = SubReddit.new(subreddit_params)
    if @subreddit.save
      redirect_to sub_reddit_url(@subreddit)
    else
      flash[:errors] = ["SUB NOT SAVED!! SORRY!!"]
      render :new
    end
  end

  def edit
    @subreddit = SubReddit.find(params[:id])
    render :edit
  end

  def update
    @subreddit = SubReddit.find(params[:id])
    if @subreddit.update_attributes(subreddit_params)
      redirect_to sub_reddit_url(@subreddit)
    else
      flash[:errors] = ["CHANGES NOT SAVED!! SORRY!!"]
      render :edit
    end
  end

  private

  def is_mod?
    redirect_to :back unless current_user.id == SubReddit.find(params[:id]).mod_id
  end

  def subreddit_params
    params.require(:sub_reddit).permit(:title, :mod_id, :description)
  end
end
