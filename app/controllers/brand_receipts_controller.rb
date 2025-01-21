class BrandReceiptsController < ApplicationController

  def index
    current_brand
    @brand_receipts = @brand.brand_receipts.order(receipt_num: :asc)
    render :index
  end

  def find
    @brand = Brand.find(params[:id])
    @brand_receipts = @brand.brand_receipts.order(receipt_num: :asc)
    set_current_brand
    render :index
  end

  def create
    @brand = Brand.find(permit_params[:brand_id])
    brand_receipt = BrandReceipt.create(permit_params)
    if brand_receipt.errors.any?
      flash[:alert] = brand_receipt.errors.full_messages.first
    else
      @brand_receipts = @brand.brand_receipts.order(receipt_num: :asc)
      render :index
    end
  end

  def new_receipt
    @brand = Brand.find(params[:id]) || current_brand
    @brand_receipts = @brand.brand_receipts.order(receipt_num: :asc)
    @new_record = true
    @brand_receipt = BrandReceipt.new
    @brand_receipt.brand_id = @brand.id
    render :index
  end

  def update
    @brand_receipt = BrandReceipt.find(params[:id])
    @brand_receipt.update(permit_params)
    @brand = @brand_receipt.brand
    @brand_receipts = @brand.brand_receipts.order(receipt_num: :asc)
    set_current_brand
    set_current_brand_receipt
    render :index
  end

  def edit_rec
    @update_record = BrandReceipt.find(params[:id])
    @brand = @update_record.brand
    @brand_receipts = @brand.brand_receipts.order(receipt_num: :asc)
    render :index
  end

  def destroy
    @brand_receipt = BrandReceipt.find(params[:id])
    @brand = @brand_receipt.brand
    set_current_brand
    if @brand_receipt.receipts.count == 0
      @brand_receipt.destroy
      @brand_receipt = @brand.brand_receipts.order(receipt_num: :asc).last
      set_current_brand_receipt
      redirect_to brand_receipts_url
    else
      flash[:alert] = "This brand receipt has receipts. Deletion cancelled!"
    end
  end

  private

  def permit_params
    params.require(:brand_receipt).permit([ :id, :density, :hardnessShA, :hardnessShD, :receipt_num, :brand_id ])
  end

  def current_brand
    @brand = session[:brand_id] ? Brand.find(session[:brand_id]) : Brand.last
  end

  def set_current_brand
    session[:brand_id] = @brand&.id
  end

  def set_current_brand_receipt
    session[:brand_receipt_id] = @brand_receipt&.id
  end

  def current_brand_receipt
    @brand_receipt = session[:brand_receipt_id] ? BrandReceipt.find(session[:brand_receipt_id]) : @brand.brand_receipts.last
  end
end
