# frozen_string_literal: true

require 'jwt_auth/modules'

module JwtAuth
  mattr_accessor :token_validity
  self.token_validity = 1.day

  mattr_accessor :refresh_token_validity
  self.refresh_token_validity = 4.weeks

  def self.config
    yield self
  end
end
