class BrandsController < ApplicationController
  def index
    @brands = Brand.all
    @status_new_rec = false
    render :index
  end

  def create_brand
    brand = Brand.create(permit_params)
    if brand.errors.any?
      flash[:alert] = brand.errors.full_messages.first
    else
      @brands = Brand.all
      render :index
    end
  end

  def find_brand
    fnd = "%#{params[:find]}%"
    @brands = Brand.where("name LIKE ? OR intended_use LIKE ? OR description LIKE ?", fnd, fnd, fnd).order(:name)
    render :index
  end

  def new_record
    @brands = Brand.all
    @status_new_rec = true
    @brand = Brand.new
    @brand.creator_id = current_user.creator.id
    render :index
  end

  private

  def permit_params
    params.require(:brand).permit([ :name, :intended_use, :description, :calculated_cost, :creator_id ])
  end
end
