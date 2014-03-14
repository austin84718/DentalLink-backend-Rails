class PracticeInvitationsController < ApplicationController
  before_action :set_practice_invitation, only: [:destroy]
  load_and_authorize_resource

  # POST /practice_invitations
  # POST /practice_invitations.json
  def create
    practice_invitation = PracticeInvitation.new(practice_invitation_params)
    practice = Practice.new({name: practice_invitation.practice_name, status: :invite})
    practice.practice_invitations << practice_invitation

    respond_to do |format|
      if practice.save
        format.json { render json: practice_invitation, status: :created }
      else
        format.json { render json: practice_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practice_invitations/1
  # DELETE /practice_invitations/1.json
  def destroy
    @practice_invitation.destroy
    respond_to do |format|
      format.json { render json: 'Invitation was successfully removed.', status: :ok }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_practice_invitation
    @practice_invitation = PracticeInvitation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def practice_invitation_params
    params.require(:practice).permit(:practice_name, :contact_first_name, :contact_last_name, :contact_email, :contact_phone)
  end
end
