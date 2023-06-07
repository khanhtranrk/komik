# frozen_string_literal: true

class Api::V1::Admin::DocumentsController < ApplicationController
  def show
    expose "#{params[:id]}": Registry.find_by(key: params[:id])
  end

  def update
    registry = Registry.find_by(key: params[:id])
    registry.update!(value: params[:value])

    expose
  end
end
