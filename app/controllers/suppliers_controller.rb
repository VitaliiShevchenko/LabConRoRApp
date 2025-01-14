class SuppliersController < ApplicationController
  before_action :authenticate_user!

  def index
    @suppliers = Supplier.all
    render :index
  end

  def create
    @supplier = Supplier.create(permit_params)
    @suppliers = Supplier.all
    render :index
  end

  def update
    @supplier = Supplier.find(params[:id])
  end

  def destroy
    @supplier = Supplier.find(params[:id])
  end

  def find_materials
    supplier = Supplier.find(params[:id])
    @materials = supplier.materials
  end

  def add_new
    @suppliers = Supplier.all
    @new_supplier = true
    @supplier = Supplier.new
    @supplier.creator_id = current_user.creator.id
    render :index
  end

  private

  def permit_params
    params.require(:supplier).permit(:name, :mobile, :phone, :website, :contact_person, :note, :active, :country,
                                      :reliability, :image, :producer, :creator_id,  product_ids: [])
  end
end
