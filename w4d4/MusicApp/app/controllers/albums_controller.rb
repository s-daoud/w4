class AlbumsController < ApplicationController
  before_action :check_logged_in

  def new
    @album = Album.new
    @band_id = params[:band_id]
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def show
    @album = Album.find(params[:id])
    @band = Band.find(@album.band_id)
    render :show
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to band_url(params[:band_id])
  end

  private

  def album_params
    params.require(:album).permit(:name, :band_id, :album_type)
  end
end
