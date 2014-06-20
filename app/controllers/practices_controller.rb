class PracticesController < ApplicationController
  before_action :set_practice, only: [:show, :edit, :update, :destroy]
  before_action :create_practice, only: [:create]
  load_and_authorize_resource except: [:search]

  skip_authorization_check only: [:search]
  skip_before_filter :authenticate_user_from_token!, only: [:search]
  skip_before_filter :authenticate_user!, only: [:search]


  # GET /practices
  # GET /practices.json
  def index
    render json: Practice.all, status: :ok
  end

  # GET /practices/1
  # GET /practices/1.json
  def show
    render json: @practice, include: [:address, :users], status: :ok
  end

  def search
    render json: Practice.where("name LIKE :search", search: "%#{params[:search]}%").limit(10), include: [:practice_type, :users]
  end


  # POST /practices
  # POST /practices.json
  def create
    respond_to do |format|
      if @practice.save
        format.json { render json: @practice, status: :created}
      else
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /practices/1
  # PATCH/PUT /practices/1.json
  def update
    respond_to do |format|
      if @practice.update(practice_params)
        format.json { render json: @practice, status: :ok }
      else
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practices/1
  # DELETE /practices/1.json
  def destroy
    @practice.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_practice
      @practice = Practice.find(params[:id])
    end

    def create_practice
      @practice = Practice.new(practice_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def practice_params
      params.require(:practice).permit(
          :name,
          :description,
          :address_id,
          :card_number,
          :card_cvc,
          :name_on_card,
          :card_exp_month,
          :card_exp_year,
          :salutation,
          :account_first_name,
          :account_last_name,
          :account_middle_initial,
          :stripe_token,
          :account_email,
          address_attributes: [:id, :street_line_1, :city, :state, :zip, :phone, :website])
    end
end
