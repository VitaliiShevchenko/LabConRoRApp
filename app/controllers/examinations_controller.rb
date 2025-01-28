class ExaminationsController < ApplicationController
  include ExaminationsHelper
  DEFAULT_TIME_TRIAL = 10
  DEFAULT_WEIGHT_SAMPLE = 30

  # before_action :crate_rtu_client
  # before_action :set_examination, only: [:show, :edit, :update, :destroy]

  def index
    @test = Test.last
    @brand_receipt = @test.brand_receipt
    render :new
  end

  def data
    render json: consistent_data_points(current_test_id)
  end

  def chart_update
           testing_time = TESTING_MACHINE.serial_clock
    measured_parameters = TESTING_MACHINE.measured_parameters
    if measured_parameters.present?
      answer = [measured_parameters[:testing_time] , testing_time]
      measured_parameters[:testing_time] = testing_time
      DataFlow.find_by(test_id: current_test_id, testing_time:).update measured_parameters
      UpdateChartsJob.perform_now(current_test_id)
    end

    render json: answer
  end

  def start
    # return continue if test_exist?
    trial_time = params[:time_trial].to_i

    set_current_test_id # test_id = 17
    create_data_area trial_time unless test_exist?

    TESTING_MACHINE.set_trial_time trial_time
    TESTING_MACHINE.set_time_from  0
    TESTING_MACHINE.start
    head :ok
  end

  def continue
    finish unless current_test_id == params[:test_id]
    head :ok if params[:sck].to_i.zero?

    TESTING_MACHINE.set_trial_time params[:time_trial].to_i
    TESTING_MACHINE.set_time_from params[:sck].to_i
    TESTING_MACHINE.start
    head :ok
  end

  def finish
    TESTING_MACHINE.stop
    index
  end

  def create

  end

  def find
    set_current_test_id
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

  def set_current_test_id
    session[:current_test_id] = params[:test_id]
  end

  def current_test_id
    session[:current_test_id] ||= nil
  end

  def set_testing_time(value)
    session[:testing_time] = value
  end

  def testing_time
    session[:testing_time]
  end

  def create_data_area(size)
    (1 + size).times { |i| DataFlow.create test_id: current_test_id, testing_time: i }
  end

  def set_trial_time(trial_time)
    session[:trial_time] = trial_time
  end

  def increment_testing_time
    session[:testing_time] += 1
  end

  def trial_time
    session[:trial_time]
  end

  def test_exist?
    DataFlow.find_by(test_id: current_test_id)
  end
end
