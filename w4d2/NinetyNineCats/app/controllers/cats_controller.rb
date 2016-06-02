class CatsController < ApplicationController
  def index
    @cats = Cat.all
    msg = UserMailer.welcome_email
    msg.deliver
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    @cat.update_attributes(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  private
    def cat_params
      params.require(:cat).permit(:birth_date, :name, :color, :sex, :description)
    end
end
