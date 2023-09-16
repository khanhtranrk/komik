# frozen_string_literal: true

class Api::V1::App::PlansController < ApplicationController
  def index
    sara :plans do |options|
      options[:each_serializer] = App::PlansSerializer
      Plan.all
    end
  end
end
