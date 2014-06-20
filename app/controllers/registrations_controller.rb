class RegistrationsController < Devise::RegistrationsController
  include ApiHelper
  skip_before_filter :verify_authenticity_token#, if: Proc.new { |c| c.request.format == 'application/json' }
  skip_before_filter :authenticate_scope!, only: [:update]
  before_filter :validate_auth_token, except: :create
  after_filter :set_csrf_header, only: [:create]
  skip_authorization_check
  respond_to :json

  def create
    build_resource(sign_up_params)
    #TODO change roles hardcoding to some other behavior
    resource.roles= [:doctor]
    resource.skip_confirmation!
    invitation = ProviderInvitation.find_by(token: params[:invitation_token], status: 'invited')
    if invitation && resource.save
      unless resource.active_for_authentication?
        expire_data_after_sign_in!
      end
      invitation.update(registered_user: resource, status: 'registered')
      render json: resource, methods: :roles, status: :ok
    else
      clean_up_passwords resource
      render status: :unprocessable_entity, json: {errors: resource.errors}
    end
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    logger.debug(params[:user])
    if resource.update_with_password(account_update_params)
      if is_navigational_format?
        update_needs_confirmation?(resource, prev_unconfirmed_email)
      end
      sign_in resource_name, resource
      render json: {success: true}
    else
      clean_up_passwords resource
      render status: :unauthorized, json: {errors: resource.errors}
    end
  end

  def account_update_params
    params.require(:user).permit( :email, :password, :password_confirmation, :current_password)
  end

  def sign_up_params
    params.require(:user).permit(:title, :email, :password, :password_confirmation, :first_name, :last_name, :practice_id, :middle_initial)
  end

  def set_csrf_header
    response.headers['X-CSRF-Token'] = form_authenticity_token
  end
end