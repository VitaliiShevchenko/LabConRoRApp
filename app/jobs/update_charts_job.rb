class UpdateChartsJob < ApplicationJob
  include ExaminationsHelper
  queue_as :default

  def perform(*args)
    test_id = args.shift
    ActionCable.server.broadcast "chart_1", consistent_data_by_x_points(test_id, 1)
  end
end
