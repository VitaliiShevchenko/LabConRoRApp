PORT        = '/dev/ttyACM1'
BAUD_RATE   = 115200
FIRST_SLAVE = 1

TESTING_MACHINE = TestingMachine.new FIRST_SLAVE, PORT, BAUD_RATE
