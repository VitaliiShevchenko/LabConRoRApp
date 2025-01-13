class CreatorDashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    render :new
  end

  def receipts
    render :receipts
  end

  def suppliers
    render :suppliers
  end

  def materials
    render :materials
  end

  def tests
    render :tests
  end
end
