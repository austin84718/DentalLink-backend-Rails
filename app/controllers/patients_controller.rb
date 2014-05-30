class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :create_patient, only: [:create]
  load_and_authorize_resource

  # GET /patients
  # GET /patients.json
  def index
    render json: Patient.all, status: :ok
  end

  def search
    render json: Patient.where('first_name LIKE :search OR last_name LIKE :search OR email LIKE :search', search: "%#{params[:search]}%").limit(10)
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    respond_to do |format|
      if @patient.save
        format.json { render json: @patient, status: :created }
      else
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.json { head :no_content }
      else
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

  def create_patient
    @patient = Patient.new(patient_params)
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:first_name, :last_name, :salutation, :middle_initial, :birthday, :email, :phone)
    end
end
