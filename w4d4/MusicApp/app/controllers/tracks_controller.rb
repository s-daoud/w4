class TracksController < ApplicationController
  before_action :check_logged_in

  def new
    @track = Track.new
    @album_id = params[:album_id]
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.all
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def show
    @track = Track.find(params[:id])
    @album = Album.find(@track.album_id)
    @notes = Note.where("track_id = ?", @track.id)
    render :show
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to album_url(params[:album_id])
  end

  private

  def track_params
    params.require(:track).permit(:name, :album_id, :track_type, :lyrics)
  end
end
