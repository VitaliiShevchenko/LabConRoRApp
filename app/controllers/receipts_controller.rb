class ReceiptsController < ApplicationController
  before_action :authenticate_user!

  def index
    render :index
  end

  def create
    render :index
  end

  def update
    render :index
  end

  def destroy
    render :index
  end

  private

  def receipt_params
    params.require(:receipt).permit(:id, :short_name, :material_id, :amount_g, :price_id, :price_sc_id, :sum_sc, :volume_cc, :sum,
                                     :short_id, :brand_receipt_id)
  end
end
