# frozen_string_literal: true

require 'jwt_auth/authenticator'
require 'jwt_auth/json_web_token'
require 'jwt_auth/login_helper'
require 'jwt_auth/helpers'
require 'jwt_auth/errors'

module JwtAuth
  module Modules
    ActiveSupport.on_load(:action_controller) do
      include JwtAuth::Authenticator
    end
  end
end
