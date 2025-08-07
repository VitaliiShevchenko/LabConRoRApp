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
      power = records.pluck(:power)
      avg_torque = torque.each_cons(points).map { |group| group.sum.to_f / points }
      avg_power2 = torque.each_cons(2).map { |group| group.sum.to_f / (2) }
      avg_power4 = avg_power2.each_cons(2).map { |group| group.sum.to_f / (2) }
      avg_power8 = avg_power4.each_cons(2).map { |group| group.sum.to_f / (2) }
      avg_power16 = avg_power8.each_cons(2).map { |group| group.sum.to_f / (2) }
      avg_power32 = avg_power16.each_cons(2).map { |group| group.sum.to_f / (2) }
      avg_power64 = avg_power32.each_cons(2).map { |group| group.sum.to_f / (2) }
      avg_power128 = avg_power64.each_cons(2).map { |group| group.sum.to_f / (2) }
      avg_power256 = avg_power128.each_cons(2).map { |group| group.sum.to_f / (2) }
      avg_power512 = avg_power256.each_cons(2).map { |group| group.sum.to_f / (2) }
      avg_power1024 = avg_power512.each_cons(2).map { |group| group.sum.to_f / (2) }
      avg_power = avg_power128
      {
        dataPoints:
          [
            torque,
            records.pluck(:speed),
            records.pluck(:mold_temp),
            records.pluck(:material_temp),
            records.pluck(:voltage),
            records.pluck(:current),
            records.pluck(:frequency),
            avg_power,
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
