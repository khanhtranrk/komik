# frozen_string_literal: true

module ErrorHandler
  module Errors
    class Unauthorized < StandardError; end

    class PermissionDenied < StandardError; end

    class ServerError < StandardError; end

    class Unknown < StandardError; end

    class BadParameter < StandardError; end

    class ParameterMissing < StandardError; end

    class NotFound < StandardError; end

    class DataExisted < StandardError; end

    class InvalidCall < StandardError; end

    class InvalidAccount < StandardError; end

    class ActionAlreadyTaken < StandardError; end

    class NotEligible < StandardError; end
  end
end
