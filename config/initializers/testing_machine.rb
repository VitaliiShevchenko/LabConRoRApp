require Rails.root.join('lib/testing_machine')

PORT        = ENV['SERIAL_PORT'] || '/dev/ttyACM0'
BAUD_RATE   = 115200
FIRST_SLAVE = 1

TESTING_MACHINE = TestingMachine.new FIRST_SLAVE, PORT, BAUD_RATE
