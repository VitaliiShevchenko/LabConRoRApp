class TestingMachine
  PIN_CODE = 2024
  ADDRESS =
    {
      start_stop:           0x0000, # Command for starting/stopping the process
      delay_turn_off:       0x2009  # the motor shuts down if the current/voltage is close to zero, s
    }
  MONITORING_ADDRESSES =
    {
      torque:              { value: 0x4000, cf: 1 }, # Store current torque of process, Nm
      speed:               { value: 0x4001, cf: 1 }, # Store current speed of the mixe, rot/min
      mold_temp:           { value: 0x4002, cf: 1 }, # Store current mold temperature, °C
      material_temp:       { value: 0x4003, cf: 1 }, # Store current mix material temperature, °C
      testing_time:        { value: 0x4004, cf: 1 }, # Store current testing time, s
      voltage:             { value: 0x4005, cf: 1 }, # Store measured voltage,V,  *1
      current:             { value: 0x4006, cf: 1000 }, # Store measured current, A, *1000
      frequency:           { value: 0x4007, cf: 10 }, # Store measured frequency, Hz, *10
      power:               { value: 0x4008, cf: 10 }, # Store power on current time, W, *10
      energy:              { value: 0x4009, cf: 1000 }, # Store total energy on the current time, kWh, *1000
      alarm:               { value: 0x400A, cf: 1 }  # Store the reason of emergency stop(in bits):
    }
  attr_accessor :id, :port, :baud_rate

  def initialize(id, port, baud_rate)
    @state = :off
    @client = ModBus::RTUClient.new port, baud_rate
    @cl_with_slave = @client.with_slave id
  end

  def start
    kill_error
    launch
    @state = :on
  end

  def stop
    return if @state == :off

    @cl_with_slave.write_holding_registers(ADDRESS[:start_stop], [ 0 ])
    @state = :off
  end

  def measured_parameters
    return {} if @state == :off
    hash = {}
    MONITORING_ADDRESSES.each do |key, hsh|
      hash[key] = @cl_with_slave.read_holding_register(hsh[:value]) / hsh[:cf]
    end

    hash
  end

  private

  def kill_error
    @cl_with_slave.write_holding_register(MONITORING_ADDRESSES[:alarm][:value], 0)
  end

  def launch
    @cl_with_slave.write_holding_register(ADDRESS[:delay_turn_off], 20) # temporary
    @cl_with_slave.write_holding_register(ADDRESS[:start_stop], PIN_CODE)
  end
end
