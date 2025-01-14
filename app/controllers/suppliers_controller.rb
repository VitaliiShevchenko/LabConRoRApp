class SuppliersController < ApplicationController
  before_action :authenticate_user!

  def index
    @suppliers = Supplier.all
    render :index
  end

  def create
    @supplier = Supplier.create(permit_params)
  end

  def update
    @supplier = Supplier.find(params[:id])
  end

  def destroy
    @supplier = Supplier.find(params[:id])
  end

  private

  def permit_params
    params.require(:suppliers).permit(:name, :mobile, :phone, :website, :contact_person, :note, :active, :country,
                                      :reliability, :image, :producer,  product_ids: [])
  end
end
