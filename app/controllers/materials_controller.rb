class MaterialsController < ApplicationController
  before_action :authenticate_user!

  def index
    @supplier = Supplier.last
    @materials = @supplier.material
    render :index
  end

  def create
    @material = Material.build(material_params)
    @supplier = Supplier.find_by(id: material_params[:supplier_id])
    @materials = @supplier.material
    if @material.save
      render :index
    else
      flash[:alert] = @material.errors.full_messages
    end
  end

  def find
    @supplier = Supplier.find(params[:id])
    @materials = @supplier.material
    render :index
  end

  def add_new
    @user_pushed_add_new = true
    @supplier = Supplier.find(params[:id])
    @materials = @supplier.material
    @material = @materials.build
    @supplier.material.reload
    render :index
  end

  def edit_rec
    @update_record = Material.find(params[:id])
    @supplier = @update_record.supplier
    @materials = @supplier.material
    render :index
  end

  def update
    update_record = Material.find(params[:id])
    update_record.update(material_params)
    if update_record.save
      @supplier = update_record.supplier
      @materials = @supplier.material
      render :index
    else
      flash[:alert] = update_record.errors.full_messages
    end
  end

  def destroy
    material = Material.find(params[:id])
    material.destroy
    @supplier = material.supplier
    @materials = @supplier.material.reload
    render :index
  end

  private

  def material_params
    params.require(:material).permit(:id, :name, :supplier_id, :description, :note, :available, :price, :density)
  end
end
