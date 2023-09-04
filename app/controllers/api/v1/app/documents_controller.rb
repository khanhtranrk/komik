# frozen_string_literal: true

class Api::V1::App::DocumentsController < ApplicationController
  skip_before_action :authenticate!

  def policy_and_terms
    expose Registry.find_by(key: :policy_and_terms)
  end

  def introduction
    expose Registry.find_by(key: :introduction)
  end
end
