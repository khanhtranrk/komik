# frozen_string_literal: true

class Api::V1::App::DocumentsController < ApplicationController
  def policy_and_terms
    expose policy_and_terms: Registry.find_by(key: :policy_and_terms)
  end

  def introduction
    expose introduction: Registry.find_by(key: :introduction)
  end
end
