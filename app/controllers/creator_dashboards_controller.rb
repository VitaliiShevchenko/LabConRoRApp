class CreatorDashboardsController < ApplicationController
  def index
    render :new
  end

  def brands
    @table_brands = Brand.all
    @brand = Brand.new
    @status_new_rec = true
    render :brands
  end

  def brand_receipts
    render :brand_receipts
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
