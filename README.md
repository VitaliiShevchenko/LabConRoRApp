# ## Welcome to the LabConRoRApp
Control equipment through the site.

### Introduction
Project using Ruby On Rails for controlling equipments through RS485 on the backend and displaying the recieved information on the dashboard in the current browser.

Things you may want to cover:

* Ruby version 3.2.2

* Rails version 7.2.2

* System dependencies:

* Configuration:

* Database creation: `$ brew instal postgresql@14`

* Database initialization: `$ brew services start postgresql@14`, `$rails db:create`

* How to run the test suite: 

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

COMMANDS:
1.  source ~/.rvm/scripts/rvm
2.  ./bin/start_server.sh

cat ./bin/start_server.sh                                                                                                                                  ──(чт,сер07)─┘
#!/bin/bash
./bin/detect_ports.sh
source ~/.serial_port_env
bundle exec rails s

cat detect_ports.sh                                                                                                                                        ──(чт,сер07)─┘
#!/bin/bash

echo "Script is running..."

# Find the first available /dev/ttyACM* port
PORT=$(ls /dev/ttyACM* 2>/dev/null | head -n 1)

# Check if a port was found
if [ -z "$PORT" ]; then
echo "No available /dev/ttyACM* port found."
exit 1
else
echo "Detected port: $PORT"
# Export the port as an environment variable
echo "export SERIAL_PORT=$PORT" > ~/.serial_port_env
exit 0
fi

