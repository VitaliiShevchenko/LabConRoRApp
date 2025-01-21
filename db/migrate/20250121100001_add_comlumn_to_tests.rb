class AddComlumnToTests < ActiveRecord::Migration[7.2]
  def change
    add_column :tests, :test_num, :integer
    add_column :tests, :weight_sample_gr, :float
    add_column :tests, :load_n, :integer
    add_column :tests, :rot_speed, :integer
    add_column :tests, :mid_voltage, :float
    add_column :tests, :mid_current, :float
    add_column :tests, :mid_frequency, :float
    add_column :tests, :mid_power, :float
    add_column :tests, :mid_temp_molds, :float
    add_column :tests, :note, :string
    add_column :tests, :color1, :string
    add_column :tests, :color2, :string
    add_column :tests, :color3, :string
    add_column :tests, :color4, :string
    add_column :tests, :dyn_stab, :float
  end
end
