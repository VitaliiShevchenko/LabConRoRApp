class BrandReceiptsController < ApplicationController

  def index
    @brand = Brand.last
    @brand_receipts = @brand.brand_receipts.order(receipt_num: :asc)
    @status_new_rec = false
    render :index
  end

  def find
    @brand = Brand.find(params[:id])
    @brand_receipts = @brand.brand_receipts.order(receipt_num: :asc)
    render :index
  end

  def create
    brand_receipt= BrandReceipt.create(permit_params)
    if brand_receipt.errors.any?
      flash[:alert] = brand_receipt.errors.full_messages.first
    else
      @brand_receipts = BrandReceipt.all
      render :index
    end
  end

  def permit_params
    params.require(:brand_receipt).permit([ :density, :hardnessShA, :hardnessShD, :receipt_num, :brand_id ])
  end
end
