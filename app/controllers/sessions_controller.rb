class SessionsController < Devise::SessionsController
  include Devise::Controllers::Helpers
  include ApiHelper

  prepend_before_filter :require_no_authentication, only: [:create]
 # skip_before_filter :verify_authenticity_token, if: Proc.new { |c| c.request.format == 'application/json' }
  before_filter :validate_auth_token, except: :create

  after_filter :set_csrf_header, only: [:create]

  respond_to :json

  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return failure unless resource

    if resource.valid_password?(params[:user][:password])
      sign_in(:user, resource)
      resource.ensure_authentication_token!
      render json: {success: true, token: resource.authentication_token}
      return
    end
    failure
  end

  def destroy
    resource.reset_authentication_token!
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    render status: :ok, json: {}
  end

  def failure
    render json: { success: false, errors: [t('auth.sessions.invalid_login')] }, status: :unauthorized
  end


  def set_csrf_header
    response.headers['X-CSRF-Token'] = form_authenticity_token
  end
end