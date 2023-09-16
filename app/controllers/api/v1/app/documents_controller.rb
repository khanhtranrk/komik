# frozen_string_literal: true

class Api::V1::App::DocumentsController < ApplicationController
  skip_before_action :authenticate!

  def policy_and_terms
    sara :documents_policy_and_terms do
      Registry.find_by(key: :policy_and_terms)
    end
  end

  def introduction
    sara :documents_introduction do
      Registry.find_by(key: :introduction)
    end
  end
end
