class NotesController < ApplicationController
  def create
    user_id = current_user.id
    track_id = params[:track_id]
    @note = Note.new(user_id: user_id, track_id: track_id, body: params[:note][:body])
    unless @note.save
      flash[:errors] = @note.errors.full_messages
    end
    redirect_to track_url(track_id)
  end

  def destroy
    @note = Note.find(params[:id])
    if @note.user_id = current_user.id
      @note.destroy
    else
      render text: "Can't touch this!", status: 403
    end
    redirect_to track_url(params[:track_id])
  end

  private

  def note_params
    params.require(:note).permit(:user_id, :track_id, :body)
  end
end
