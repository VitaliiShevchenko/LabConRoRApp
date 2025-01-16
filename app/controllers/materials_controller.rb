class MaterialsController < ApplicationController
  before_action :authenticate_user!

  def index
    @materials = Material.all
    render :index
  end

  def find
    @supplier = Supplier.find(params[:id])
    @materials = @supplier.material
    render :index
  end

  private

  def material_params
    params.require(:material).permit(:id, :name, :supplier_id, :description, :note, :available, :price)
  end
end
