class ExaminationsController < ApplicationController
  # before_action :set_examination, only: [:show, :edit, :update, :destroy]

  def index
    render :new
  end
end
