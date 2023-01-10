# frozen_string_literal: true

module JwtAuth
  module Issuer
    module_function

    def access_token(user)
      JwtAuth::JsonWebToken.encode(user.is_a?(Integer) ? user : user.id)
    end

    def access_and_refresh_token(user)
      [
        JwtAuth::JsonWebToken.encode(user.is_a?(Integer) ? user : user.id),
        JwtAuth::RefrezhToken.new_refresh_token(user.is_a?(Integer) ? user : user.id)
      ]
    end
  end
end
