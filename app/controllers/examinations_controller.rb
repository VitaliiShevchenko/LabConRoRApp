class ExaminationsController < ApplicationController
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
    set_current_test_id
    data_points = DataFlow.where(test_id: current_test_id).order(:testing_time)
    render json: ([
      data_points.pluck(:torque),
      data_points.pluck(:speed),
      data_points.pluck(:mold_temp),
      data_points.pluck(:material_temp),
      data_points.pluck(:voltage),
      data_points.pluck(:current),
      data_points.pluck(:frequency),
      data_points.pluck(:power),
      data_points.pluck(:energy),
      data_points.pluck(:alarm),
      data_points.pluck(:testing_time)
    ]).to_json
  end

  def chart_update
    if testing_time >= trial_time
      TESTING_MACHINE.stop
    else
      row = DataFlow.find_by(test_id: current_test_id, testing_time: testing_time)
      measured_parameters = TESTING_MACHINE.measured_parameters
      unless measured_parameters.empty?
        measured_parameters[:testing_time] = testing_time
        row.update measured_parameters

        UpdateChartJob.perform_now(current_test_id)
        increment_testing_time
      end
    end

    head :ok
  end

  def start
    # return finish if test_exist?

    set_current_test_id # test_id = 17
    set_trial_time trial_time = params[:time_trial].to_i
    create_data_area trial_time unless test_exist?

    set_testing_time 0
    TESTING_MACHINE.start

    index
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
    size.times { |i| DataFlow.create test_id: current_test_id, testing_time: i }
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
