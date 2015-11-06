class NotesController < ApplicationController
  def new
    render :new
  end

  def create
    @note = Note.new(note_params)
    @note.track_id = params[:track_id]
    @note.user_id = current_user.id
    if @note.save
      redirect_to track_url(@note.track_id)
    else
      flash.now[:errors] = @note.errors.full_messages
    end
  end

  def note_params
    params.require(:note).permit(:body)
  end

end
