class ProviderInvitationsController < ApplicationController
  include MailHelper
  rescue_from ActiveRecord::RecordNotUnique, with: :email_exists
  before_action :create_invitation, only: [:create]
  before_action :set_invitation, only: [:destroy]
  load_and_authorize_resource except: [:show]
  skip_authorization_check only: [:show]
  skip_before_filter :authenticate_user_from_token!, only: [:show]
  skip_before_filter :authenticate_user!, only: [:show]
  # GET /invitations/:token
  def show
    invitation = ProviderInvitation.find_by(token: params[:invitation_token], status: 'invited')
    if invitation
      render json: invitation, status: :ok
    else
      render json: {error: 'Invalid token.'}, status: :not_found
    end
  end

  def invitees
    render json: ProviderInvitation.where(inviter_id: params[:user_id]), include: [
        registered_user: {
            include: {practice: {only: [:id, :name, :description]}},
            only: [:first_name, :last_name, :id, :middle_initial, :title]
        }
    ], status: :ok
  end

  # POST /provider_invitations
  # POST /provider_invitations.json
  def create
    @provider_invitation.status = 'invited'
    respond_to do |format|
      if @provider_invitation.save
        send_provider_invitation @provider_invitation
        format.json { render json: @provider_invitation, status: :created}
      else
        format.json { render json: @provider_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @provider_invitation.status != 'registered' and @provider_invitation.destroy
      render json: @provider_invitation, status: :ok
    else
      render json: @provider_invitation.errors, status: :unprocessable_entity
    end
  end

  private

  def email_exists
    render json: { message: 'Email already exists'}, status: :conflict
  end

  def send_provider_invitation(invitation)
    send_email({
                   template_name: 'provider-invitation',
                   template_content: {},
                   merge_vars:
                       [{
                            rcpt: invitation.email,
                            vars: [
                                {name: 'FIRST_NAME', content: invitation.first_name},
                                {name: 'LAST_NAME', content: invitation.last_name},
                                {name: 'TOKEN', content: invitation.token},
                            ]
                        }
                       ],
                   recipients: [ {email: invitation.email, name: "#{invitation.first_name} #{invitation.last_name}", type: 'to'} ]
               })
  end


  # Use callbacks to share common setup or constraints between actions.
    def create_invitation
      @provider_invitation = ProviderInvitation.new(provider_invitation_params)
    end

    def set_invitation
      @provider_invitation = ProviderInvitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_invitation_params
      params.require(:provider_invitation).permit(:first_name, :last_name, :email, :inviter_id)
    end
end
