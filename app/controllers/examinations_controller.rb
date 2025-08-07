class ExaminationsController < ApplicationController
  include ExaminationsHelper
  DEFAULT_TIME_TRIAL = 3600
  DEFAULT_WEIGHT_SAMPLE = 40

  def index
    @test = Test.last
    @brand_receipt = @test.brand_receipt
    render :new
  end

  def torques_analyzing
    index
  end

  def data
    render json: consistent_data_by_x_points(current_test_id, 33)
  end

  def chart_update
    testing_time = TESTING_MACHINE.serial_clock
    measured_parameters = TESTING_MACHINE.measured_parameters
    if measured_parameters.present?
      serial_clock_diff = [ measured_parameters[:testing_time], testing_time ]
      DataflowService.create_update_record(current_test_id, measured_parameters, testing_time)
      UpdateChartsJob.perform_now(current_test_id)
    end

    render json: serial_clock_diff
  end

  def start
    return finish if test_exist?

    set_current_test_id
    #create_data_area(trial_time) unless test_exist?

    TESTING_MACHINE.set_trial_time(trial_time)
    TESTING_MACHINE.set_time_from(0)
    TESTING_MACHINE.start
    render json: :run
  end

  def continue
    return finish if test_ids_no_match || sck_zero_or_more

    #create_data_area(trial_time)
    TESTING_MACHINE.set_trial_time(trial_time)
    TESTING_MACHINE.set_time_from(current_clock)
    TESTING_MACHINE.start
    render json: :run
  end

  def finish
    TESTING_MACHINE.stop
    render json: :finish
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
    quantity_rec = DataFlow.where(test_id: current_test_id).size
    (1 + size - quantity_rec).times { |i| DataFlow.create test_id: current_test_id, testing_time: (i + quantity_rec) }
  end

  def trial_time
    params[:time_trial].to_i
  end

  def test_exist?
    DataFlow.find_by(test_id: current_test_id)
  end

  def test_ids_no_match
    current_test_id != params[:test_id]
  end

  def sck_zero_or_more
    params[:sck].to_i.zero? || params[:sck].to_i > params[:time_trial].to_i
  end

  def current_clock
    params[:sck].to_i
  end
end
