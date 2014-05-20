class ProceduresController < ApplicationController
  before_action :set_procedure, only: [:update, :destroy]

  load_and_authorize_resource


  # GET /procedures
  # GET /procedures.json
  def index
    render json: Procedure.all, status: :ok
  end

  def practice_types
    render json: PracticeType.all, status: :ok, include: [:procedures]
  end

  # POST /procedures
  # POST /procedures.json
  def create
    @procedure = Procedure.new(procedure_params)

    respond_to do |format|
      if @procedure.save
        format.json { render json: @procedure, status: :created }
      else
        format.json { render json: @procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /procedures/1
  # PATCH/PUT /procedures/1.json
  def update
    respond_to do |format|
      if @procedure.update(procedure_params)
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /procedures/1
  # DELETE /procedures/1.json
  def destroy
    @procedure.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_procedure
      @procedure = Procedure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def procedure_params
      params[:procedure]
    end
end
