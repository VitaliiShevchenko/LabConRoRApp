# frozen_string_literal: true

class WelcomeController < ApplicationController
  include CreatorHelper
  before_action :authenticate_user!
  before_action :require_creator

  def index
    render "welcome"
  end

  private

  def require_creator
    is_creator? current_user.email
  end
end
