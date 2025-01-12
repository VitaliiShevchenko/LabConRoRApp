class CreatorDashboardsController < ApplicationController

  def index
    render :new
  end

  def brands
    @brands = Brand.all
    @status_new_rec = false
    render :brands
  end

  def create_brand
    brand = Brand.create(permit_params)
    if brand.errors.any?
      flash[:alert] = brand.errors.full_messages.first
    else
      @brands = Brand.all
      render :brands
    end
  end

  def find_brand
    fnd = "%#{params[:find]}%"
    @brands = Brand.where("name LIKE ? OR intended_use LIKE ? OR description LIKE ?", fnd, fnd, fnd).order(:name)
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

  def new_record
    @brands = Brand.all
    @status_new_rec = true
    @brand = Brand.new
    @brand.creator_id = current_user.creator.id
    render :brands
  end

  private
  def is_new_record?
    @new_record ||= false
  end

  def permit_params
    params.require(:brand).permit([ :name, :intended_use, :description, :calculated_cost, :creator_id ])
  end
end
