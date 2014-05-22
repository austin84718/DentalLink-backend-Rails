class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :create_user, only: [:create, :invite]
  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    render json: User.all, status: :ok
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @user
  end


  # POST /users
  # POST /users.json
  def invite
    respond_to do |format|
      @user.status = 'invited'
      @user.skip_confirmation!
      if @user.save(validate:false);
        format.json { render json: @user, status: :created}
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    respond_to do |format|
      if @user.save
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json { head :no_content }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

  def create_user
    @user = User.new(user_params)
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:group, :title, :first_name, :email, :middle_initial, :last_name, :username, :password, :practice_id, :roles)
    end
end
