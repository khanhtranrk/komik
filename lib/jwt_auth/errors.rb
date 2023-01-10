# frozen_string_literal: true

module JwtAuth
  module Errors
    class MissingToken < StandardError; end
    class InvalidToken < StandardError; end
  end
end
