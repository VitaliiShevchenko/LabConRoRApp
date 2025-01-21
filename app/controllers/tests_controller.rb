class TestsController < ApplicationController
  before_action :authenticate_user!

  def index
    current_brand
    current_brand_receipt
    @tests = @brand_receipt.tests.all.order(test_num: :asc)
    render :index
  end

  def create
    test= Test.new(test_params)
    test.creator_id = current_user.creator.id
    if test.save
      @brand_receipt = test.brand_receipt
      set_current_brand_receipt
      redirect_to tests_url
    else
      flash.now[:error] = test.errors.full_messages.to_sentence
      debugger
    end
  end

  def update
    @test = Test.find(params[:id])
    if @test.update(test_params)
      @brand_receipt = @test.brand_receipt
      set_current_brand_receipt
      redirect_to tests_url
    else
      flash.now[:error] = @test.errors.full_messages.to_sentence
    end
  end

  def destroy
    @test = Test.find(params[:id])
    if @test.destroy
      @brand_receipt = @test.brand_receipt
      set_current_brand_receipt
      redirect_to tests_url
    else
      flash.now[:error] = @test.errors.full_messages.to_sentence
    end
  end

  def find
    @brand_receipt_id = params[:brand_receipt_id]
    @brand_receipt = BrandReceipt.find(@brand_receipt_id)
    set_current_brand_receipt
    @brand = @brand_receipt.brand
    @tests = Test.where(brand_receipt_id: @brand_receipt_id).order(test_num: :asc)
    render :index
  end

  def add_new
    @user_pushed_add_new = true
    @brand_receipt = BrandReceipt.find(params[:id])
    set_current_brand_receipt
    @brand = @brand_receipt.brand
    @test= @brand_receipt.tests.build
    @tests = @brand_receipt.tests
    @brand_receipt.tests.reload
    render :index
  end

  def edit_rec
    @update_record = Test.find(params[:id])
    @brand_receipt = @update_record.brand_receipt
    @tests = @brand_receipt.tests.order(test_num: :asc)
    @brand = @brand_receipt.brand
    render :index
  end

  private

  def test_params
    params.require(:test).permit(:id, :brand_receipt_id, :creator_id, :total_time, :temperature, :torque1, :time1,
                                 :torque2, :time2, :torque3, :time3, :torque4, :time4, :melting_time, :start_melting,
                                 :end_melting, :total_energy, :te_persec, :test_num, :weight_sample_gr, :load_n,
                                 :rot_speed, :mid_voltage, :mid_current, :mid_frequency, :mid_power, :mid_temp_molds,
                                 :color1, :color2, :color3, :color4, :dyn_stab, :note)
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
