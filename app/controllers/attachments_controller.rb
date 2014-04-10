class AttachmentsController < ApplicationController
  include S3Helper
  before_action :set_attachment, only: [:destroy]
  before_action :create_attachment, only: [:create]

  load_and_authorize_resource

  # POST /attachments
  # POST /attachments.json
  def create
    unless @attachment.patient_id
      @attachment.patient = @attachment.referral.patient if @attachment.referral
    end

    respond_to do |format|
      if @attachment.save
        format.json { render json: @attachment, status: :created }
      else
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def s3_credentials
    respond_to do |format|
      format.json {render json: {s3_policy: s3_policy, s3_signature: s3_signature, s3_access_key_id: s3_access_key_id}, status: :ok}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

  def create_attachment
    @attachment = Attachment.new(attachment_params)
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:filename, :referral_id, :patient_id, :notes)
    end
end
