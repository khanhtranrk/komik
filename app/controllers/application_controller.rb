# frozen_string_literal: true

class ApplicationController < ActionController::API
  include LazyLookup

  before_action :authenticate!
end
