class ApplicationController < ActionController::Base

  # Use HTTP basic authentication.
  http_basic_authenticate_with  name: Rails.configuration.tracker_auth['user'],
                                password: Rails.configuration.tracker_auth['password']

end