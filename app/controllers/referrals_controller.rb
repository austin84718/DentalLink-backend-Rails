class ReferralsController < ApplicationController
  include InviteHelper
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
    respond_to do |format|
      format.json { render json: @referral, include: [:patient, :orig_practice]}
    end
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
     @referral.dest_practice = invite_practice(practice_invitation_params)
    end

    unless @referral.patient_id
      patient = Patient.create(patient_params)
      @referral.patient = patient
    end

    unless @referral.orig_practice_id
      @referral.orig_practice = current_user.practice
    end

    @referral.status = :sent

    respond_to do |format|
      if @referral.save
        send_email_to_doctor(@referral.dest_practice)
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

  def send_email_to_doctor(dest_practice)
    dest_practice.users.each do |user|
      send_email({
                     html: "<h2>You have received new referral!</h2><p>Click <a href='http://referral-frontend.s3-website-us-east-1.amazonaws.com/pages/#/sign_in'>here</a> to see the referral that doctor #{self.orig_practice.users.first.first_name} #{self.orig_practice.users.first.last_name} just sent you.</p>",
                     text: "Dear #{user.first_name} #{user.last_name}, You have received a new referral! Visit this URL to see the referral that doctor #{current_user.first_name} #{current_user.middle_initial} #{current_user.last_name} just sent you: http://referral-frontend.s3-website-us-east-1.amazonaws.com/pages/#/sign_in",
                     subject: 'You have received a referral!',
                     from_email: 'dental.links@example.com',
                     from_name: 'Dental Links Team',
                     to_email: user.email,
                     to_name: "#{user.first_name} #{user.last_name}"

                 })
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_referral
      @referral = Referral.find(params[:id])
    end

  def create_referral
    @referral = Referral.new(referral_params)
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def referral_params
      params.require(:referral).permit(:orig_practice_id, :dest_practice_id, :patient_id, :memo, :status)
    end

    def practice_invitation_params
      params.require(:practice).permit(:contact_first_name, :contact_last_name, :contact_email, :practice_name, :contact_phone)
    end

    def patient_params
      params.require(:patient).permit(:first_name, :last_name, :birthday, :email, :phone)
    end
end
