class DataflowService
  def self.create_update_record(test_id, measured_parameters, testing_time)
    measured_parameters[:test_id] = test_id
    measured_parameters[:testing_time] = testing_time
    record = DataFlow.find_by(test_id:, testing_time:)
    return DataFlow.create(measured_parameters) if record.nil?

    record.update(measured_parameters)
  end
end
