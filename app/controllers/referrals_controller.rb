class ReferralsController < ApplicationController
  include MailHelper

  before_action :set_referral, only: [:show, :edit, :update, :change_status, :destroy]
  before_action :create_referral, only: [:create, :save_template]
  load_and_authorize_resource
  # GET /referrals
  # GET /referrals.json
  def index
    render json: Referral.all, include: [:dest_provider, :orig_provider, :procedure]
  end

  def referrals_by_practice
    render json: Referral
    .where('orig_practice_id = :id OR dest_practice_id = :id', id: params[:id])
    .where(created_at: params[:start_date]..params[:end_date]),
           include: [:orig_practice, :dest_practice, :dest_provider, :orig_provider, :patient]
  end


  # GET /referrals/1
  # GET /referrals/1.json
  def show
    respond_to do |format|
      format.json { render json: @referral, include: {
          patient: {},
          attachments: {},
          procedure: {include: :practice_type},
          orig_provider: {include: :practice},
          dest_provider: {include: {practice: {include: {users: {}, address: {}}}}},
          notes: {include: :user}} }
    end
  end

  # POST /referrals
  # POST /referrals.json
  def create
    prepare_referral
    @referral.status = :sent

    respond_to do |format|
      if @referral.save
        send_email_to_doctor(@referral.dest_practice)
        format.json { render json: @referral, status: :created }
      else
        format.json { render json: @referral.errors, status: :unprocessable_entity }
      end
    end
  end

  def prepare_referral
    unless @referral.patient_id
      patient = Patient.create(patient_params)
      @referral.patient = patient
    end

    unless @referral.orig_practice_id
      @referral.orig_practice = current_user.practice
    end

    unless @referral.orig_provider_id
      @referral.orig_provider = current_user
    end

    if params[:attachments]
      params[:attachments].each do |attachment|
        @referral.attachments << Attachment.new({filename: attachment[:url], notes: attachment[:notes], referral_id: @referral.id, patient_id: @referral.patient.id})
      end
    end
  end

  #this method is used for saving not-ready referral. It then should be reviewed by provider (doctor) and sent to destination.
  def save_template
    prepare_referral
    @referral.status = :new
    respond_to do |format|
      if @referral.save
        format.json { render json: @referral, status: :created }
      else
        format.json { render json: @referral.errors, status: :unprocessable_entity }
      end
    end
  end

  #PUT /referrals/1/status
  def change_status
    respond_to do |format|
      if @referral.update(status_params)
        send_status_emails (status_params[:status])
        format.json { render json: @referral, status: :ok }
      else
        format.json { render json: @referral.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /referrals/1
  # PATCH/PUT /referrals/1.json
  def update
    prepare_referral
    respond_to do |format|
      if @referral.update(referral_params)
        format.json { render json: @referral, status: :ok }
      else
        format.json { render json: @referral.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referrals/1
  # DELETE /referrals/1.json
  def destroy
    @referral.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def send_status_emails(status)
    recipients = @referral.orig_practice.users
    send_email({
                   template_name: "referral-status",
                   template_content: {},
                   global_merge_vars: {},
                   merge_vars: recipients.map { |u| {
                       rcpt: u.email,
                       vars: [
                           {name: 'FIRST_NAME', content: u.first_name},
                           {name: 'LAST_NAME', content: u.last_name},
                           {name: 'STATUS', content: status},
                           {name: 'REFERRAL_ID', content: @referral.id}
                       ]
                   } },
                   recipients: recipients.map { |u| {email: u.email, name: "#{u.first_name} #{u.last_name}", type: 'to'} }
               })
  end


  def send_email_to_doctor(dest_practice)
    recipients = @referral.orig_practice.users
    send_email({
                   template_name: 'referral-notification',
                   template_content: {},
                   merge_vars:
                       recipients.map { |u| {
                           rcpt: u.email,
                           vars: [
                               {name: 'FIRST_NAME', content: u.first_name},
                               {name: 'LAST_NAME', content: u.last_name},
                               {name: 'REFERRAL_ID', content: @referral.id}
                           ]
                       } },
                   recipients: recipients.map { |u| {email: u.email, name: "#{u.first_name} #{u.last_name}", type: 'to'} }
               })
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
    params.require(:referral).permit(:orig_practice_id, :dest_practice_id, :patient_id, :memo, :status, :teeth, :procedure_id, :dest_provider_id, notes_attributes: [:id, :message, :created_at, :referral_id, :user_id])
  end

  def practice_invitation_params
    params.require(:practice).permit(:contact_first_name, :contact_last_name, :contact_email, :practice_name, :contact_phone)
  end

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :birthday, :email, :phone)
  end

  def status_params
    params.require(:referral).permit(:status)
  end

end
