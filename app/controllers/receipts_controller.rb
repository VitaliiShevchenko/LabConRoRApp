class ReceiptsController < ApplicationController
  before_action :authenticate_user!

  def index
    current_brand
    current_brand_receipt
    @receipts = @brand_receipt.receipts.all
    render :index
  end

  def create
    receipt = Receipt.new(receipt_params)
    if receipt.save
      @brand_receipt = receipt.brand_receipt
      set_current_brand_receipt
      redirect_to receipts_url
    else
      flash.now[:error] = receipt.errors.full_messages.to_sentence
    end
  end

  def update
    @receipt = Receipt.find(params[:id])
    if @receipt.update(receipt_params)
      @brand_receipt = @receipt.brand_receipt
      set_current_brand_receipt
      redirect_to receipts_url
    else
      flash.now[:error] = @receipt.errors.full_messages.to_sentence
    end
  end

  def destroy
    @receipt = Receipt.find(params[:id])
    if @receipt.destroy
      @brand_receipt = @receipt.brand_receipt
      set_current_brand_receipt
      redirect_to receipts_url
    else
      flash.now[:error] = @receipt.errors.full_messages.to_sentence
    end
  end

  def find
    @brand_receipt_id = params[:brand_receipt_id]
    @brand_receipt = BrandReceipt.find(@brand_receipt_id)
    set_current_brand_receipt
    @brand = @brand_receipt.brand
    @receipts = Receipt.where(brand_receipt_id: @brand_receipt_id)
    render :index
  end

  def add_new
    @user_pushed_add_new = true
    @brand_receipt = BrandReceipt.find(params[:id])
    set_current_brand_receipt
    @brand = @brand_receipt.brand
    @receipt = @brand_receipt.receipts.build
    @receipts = @brand_receipt.receipts
    @brand_receipt.receipts.reload
    render :index
  end

  def edit_rec
    @update_record = Receipt.find(params[:id])
    @brand_receipt = @update_record.brand_receipt
    @receipts = @brand_receipt.receipts
    @brand = @brand_receipt.brand
    render :index
  end

  private

  def receipt_params
    params.require(:receipt).permit(:id, :short_name, :material_id, :amount_kg,
                                    :volume_cc, :sum, :short_id, :brand_receipt_id, :note)
  end

  def current_brand
    @brand = session[:brand_id] ? Brand.find(session[:brand_id]) : Brand.all.last
  end

  def set_current_brand
    session[:brand_id] = @brand&.id
  end

  def set_current_brand_receipt
    session[:brand_receipt_id] = @brand_receipt&.id
  end

  def current_brand_receipt
    @brand_receipt = session[:brand_receipt_id] ? BrandReceipt.find(session[:brand_receipt_id]) : @brand.brand_receipts.all.last
  end
end
