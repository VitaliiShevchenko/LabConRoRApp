class ExaminationsController < ApplicationController
  # before_action :set_examination, only: [:show, :edit, :update, :destroy]

  def index
    @test = Test.last
    @brand_receipt = @test.brand_receipt
    render :new
  end

  def create

  end

  def find
    @test = Test.find params[:test_id]
    @brand_receipt = @test.brand_receipt
    render :new
  end

  def update

  end

  def destroy

  end

  private

  def examinations_params
    params.require(:examination).permit(:total_time, :brand_id, :brand_id, :date, :reason, :test)
  end
end
