# frozen_string_literal: true

class WelcomeController < ApplicationController
  before_action :authenticate_user!
  before_action :require_creator
  def index
    render "welcome"
  end

  private

  def require_creator

  end
end
