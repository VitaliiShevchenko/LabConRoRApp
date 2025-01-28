module ExaminationsHelper
  def consistent_data_points(records)
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
    ]
  end
end
