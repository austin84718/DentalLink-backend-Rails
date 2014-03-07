module ApiHelper
  def validate_auth_token
    self.resource = User.find_by_authentication_token(params[:authentication_token] || request.headers['Authorization'])
    render status: :unauthorized, json: {errors: [t('auth.token.invalid_token')]} if self.resource.nil?
  end
end
