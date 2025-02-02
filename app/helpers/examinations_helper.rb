module ExaminationsHelper
  def consistent_data_points(test_id)
    begin
      records = DataFlow.where(test_id:).order(:testing_time)
      {
        dataPoints:
          [
          records.pluck(:torque),
          records.pluck(:speed),
          records.pluck(:mold_temp),
          records.pluck(:material_temp),
          records.pluck(:voltage),
          records.pluck(:current),
          records.pluck(:frequency),
          records.pluck(:power),
          records.pluck(:energy),
          records.pluck(:alarm),
          records.pluck(:testing_time)
        ],
        averageValues:
          [
            records.average(:voltage),
            records.average(:current),
            records.average(:frequency),
            records.average(:power),
            records.average(:energy)
          ]
      }

    rescue ActiveRecord::RecordNotFound
      [ [] ]
    end
  end

  def consistent_data_by_x_points(test_id, points)
    begin
      records = DataFlow.where(test_id:).order(:testing_time)
      torque = records.pluck(:torque)
      avg_torque = torque.each_cons(points).map { |group| group.sum.to_f / points }
      {
        dataPoints:
          [
            avg_torque,
            records.pluck(:speed),
            records.pluck(:mold_temp),
            records.pluck(:material_temp),
            records.pluck(:voltage),
            records.pluck(:current),
            records.pluck(:frequency),
            records.pluck(:power),
            records.pluck(:energy),
            records.pluck(:alarm),
            records.pluck(:testing_time)
          ],
        averageValues:
          [
            records.average(:voltage),
            records.average(:current),
            records.average(:frequency),
            records.average(:power),
            records.average(:energy)
          ]
      }

    rescue ActiveRecord::RecordNotFound
      [ [] ]
    end
  end
end
