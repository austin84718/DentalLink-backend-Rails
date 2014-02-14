class PracticeInvitationsController < ApplicationController
  before_action :set_practice_invitation, only: [:show, :edit, :update, :destroy]


  # POST /practice_invitations
  # POST /practice_invitations.json
  def create
    @practice_invitation = PracticeInvitation.new(practice_invitation_params)

    respond_to do |format|
      if @practice_invitation.save
        format.html { redirect_to @practice_invitation, notice: 'Practice invitation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @practice_invitation }
      else
        format.html { render action: 'new' }
        format.json { render json: @practice_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practice_invitations/1
  # DELETE /practice_invitations/1.json
  def destroy
    @practice_invitation.destroy
    respond_to do |format|
      format.html { redirect_to practice_invitations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_practice_invitation
      @practice_invitation = PracticeInvitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def practice_invitation_params
      params[:practice_invitation]
    end
end
