class ExaminationsController < ApplicationController
  # before_action :set_examination, only: [:show, :edit, :update, :destroy]

  def index
    @test = Test.new
    @test.created_at = Date.today
    @test.total_time = 600
    @test.brand_receipt_id = "XLF A6540BL"
    render :new
  end
end
