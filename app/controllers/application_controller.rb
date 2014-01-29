class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user_from_token!
  # This is Devise's authentication
  before_filter :authenticate_user!

  respond_to :json

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :first_name, :last_name, :practice, :practice_id) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:authentication_token, :username, :email, :password) }
  end

  private

  def authenticate_user_from_token!

    user_email = params[:email].presence
    user = user_email && User.find_by_email(user_email)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, params[:authentication_token])
      sign_in user, store: false
    end
  end
end
