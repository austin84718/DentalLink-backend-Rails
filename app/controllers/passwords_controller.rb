class PasswordsController < Devise::PasswordsController
  #skip_before_filter :verify_authenticity_token#, if: Proc.new { |c| c.request.format == 'application/json' }
  after_filter :set_csrf_header, only: [:create]
  skip_authorization_check

  respond_to :json

  def create
    @user = User.send_reset_password_instructions(params[:user])
    if successfully_sent?(@user)
      render status: :ok, json: { success: true }
    else
      render status: :unprocessable_entity, json: { errors: @user.errors.full_messages }
    end
  end

  def set_csrf_header
    response.headers['X-CSRF-Token'] = form_authenticity_token
  end
end