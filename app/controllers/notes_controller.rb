class NotesController < ApplicationController
  before_action :set_note, only: [:destroy]
  before_action :create_note, only: [:create]
  load_and_authorize_resource

  # POST /notes
  # POST /notes.json
  def create
    respond_to do |format|
      if @note.save
        format.json { render json: @note, status: :created, include: [:user] }
      else
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

  def create_note
    @note = Note.new(note_params)
    @note.user_id = current_user.id
  end


  # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:message, :referral_id)
    end
end
