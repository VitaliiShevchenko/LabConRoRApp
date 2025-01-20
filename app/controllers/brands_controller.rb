class BrandsController < ApplicationController
  def index
    @brands = Brand.all
    render :index
  end

  def create_brand
    brand = Brand.create(permit_params)
    if brand.errors.any?
      flash[:alert] = brand.errors.full_messages.first
    else
      redirect_to :brands
    end
  end

  def update
    @brand = Brand.find(permit_params[:id])
    if @brand.update(permit_params)
      redirect_to :brands
    else
      flash[:alert] = @brand.errors.full_messages.first
    end
  end

  def find_brand
    fnd = "%#{permit_params[:name]}%"
    @brands = Brand.where("name LIKE ? OR
                   intended_use LIKE ? OR
                    description LIKE ?", fnd, fnd, fnd).order(:name)
    render :index
  end

  def new_record
    @brands = Brand.all
    @new_brand = true
    @brand = Brand.new
    @brand.creator_id = current_user.creator.id
    render :index
  end

  def edit_rec
    @update_record = Brand.find(params[:id])
    @brands = Brand.all
    render :index
  end

  def destroy
    @brand = Brand.find(params[:id])
    if @brand.brand_receipts.empty? && @brand.destroy
      @brands = Brand.all
      render :index
    else
      flash[:alert] = @brand.errors.full_messages.first
    end
  end

  private

  def permit_params
    params.require(:brand).permit([ :id, :name, :intended_use, :description, :calculated_cost, :creator_id ])
  end
end
