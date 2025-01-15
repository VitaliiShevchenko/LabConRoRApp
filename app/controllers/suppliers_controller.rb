class SuppliersController < ApplicationController
  before_action :authenticate_user!

  def index
    @suppliers = Supplier.all.order(name: :desc)
    render :index
  end

  def create
    @supplier = Supplier.create(permit_params)
    @suppliers = Supplier.all.order(name: :desc)
    render :index
  end

  def update
    @supplier = Supplier.find(params[:id])
    @supplier.update(permit_params)
    @suppliers = Supplier.all.order(name: :desc)
    render :index
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    @suppliers = Supplier.all.order(name: :desc)
    render :index
  end

  def find_materials
    @supplier = Supplier.find(params[:id])
    @materials = @supplier.material
    redirect_to :materials_creator_dashboards
  end

  def add_new
    @suppliers = Supplier.all.order(name: :desc)
    @new_supplier = true
    @supplier = Supplier.new
    @supplier.creator_id = current_user.creator.id
    render :index
  end

   def edit_rec
     @update_record = Supplier.find(params[:id])
     @suppliers = Supplier.all.order(name: :desc)
     render :index
   end

  def find
    fnd = "%#{permit_params[:name]}%"
    @suppliers = Supplier.where("name LIKE ? OR
                                  address LIKE ? OR
                                  contact_person LIKE ? OR
                                  note LIKE ? OR
                                  mobile LIKE ? OR
                                  phone LIKE ? OR
                                  website LIKE ? OR
                                  image LIKE ? OR
                                  product_list LIKE ? OR
                                  country LIKE ?",
                                fnd, fnd, fnd, fnd, fnd,fnd, fnd, fnd, fnd, fnd).order(:name)
    render :index
  end

  private

  def permit_params
    params.require(:supplier).permit(:id, :name, :mobile, :phone, :website, :contact_person, :note, :active, :country,
                                     :reliability, :image, :producer, :creator_id, :product_list,  product_ids: [])
  end
end
