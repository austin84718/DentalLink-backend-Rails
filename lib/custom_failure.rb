class CustomFailure < Devise::FailureApp

  # We are sending only 401 response status code instead of redirection (in case of navigational formats requests)
  def respond
    http_auth
  end
end