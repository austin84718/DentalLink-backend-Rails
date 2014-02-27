class ReferralsController < ApplicationController
  before_action :set_referral, only: [:show, :edit, :update, :destroy]
  before_action :create_referral, only: [:create]
  load_and_authorize_resource
  # GET /referrals
  # GET /referrals.json
  def index
    @referrals = Referral.all
  end

  # GET /referrals/1
  # GET /referrals/1.json
  def show
  end

  # GET /referrals/new
  def new
    @referral = Referral.new
  end

  # GET /referrals/1/edit
  def edit
  end

  # POST /referrals
  # POST /referrals.json
  def create

    unless @referral.dest_practice_id
      practice_invite = PracticeInvitation.create(practice_invitation_params)
      practice = Practice.create({name: practice_invite.practice_name, status: :invite})
      practice.practice_invitations << practice_invite
      @referral.dest_practice = practice
    end

    unless @referral.patient_id
      patient = Patient.create(patient_params)
      @referral.patient = patient
    end

    unless @referral.orig_practice_id
      @referral.orig_practice = current_user.practice
    end

    respond_to do |format|
      if @referral.save
        format.html { redirect_to @referral, notice: 'Referral was successfully created.' }
        format.json { render json: @referral, status: :created, location: @referral }
      else
        format.html { render action: 'new' }
        format.json { render json: @referral.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /referrals/1
  # PATCH/PUT /referrals/1.json
  def update
    respond_to do |format|
      if @referral.update(referral_params)
        format.html { redirect_to @referral, notice: 'Referral was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @referral.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referrals/1
  # DELETE /referrals/1.json
  def destroy
    @referral.destroy
    respond_to do |format|
      format.html { redirect_to referrals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_referral
      @referral = Referral.find(params[:id])
    end

  def create_referral
    @referral = Referral.new(referral_params)
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def referral_params
      params.require(:referral).permit(:orig_practice_id, :dest_practice_id, :patient_id, :memo)
    end

    def practice_invitation_params
      params.require(:practice).permit(:contact_first_name, :contact_last_name, :contact_email, :practice_name, :contact_phone)
    end

    def patient_params
      params.require(:patient).permit(:first_name, :last_name, :birthday, :email, :phone)
    end
end
