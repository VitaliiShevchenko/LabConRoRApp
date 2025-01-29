1. Create the Bash Script in the bin/bash project in the detect_ports.sh

___ script _____________________________________

#!/bin/bash

#### Find the first available /dev/ttyACM* port
PORT=$(ls /dev/ttyACM* 2>/dev/null | head -n 1)

#### Check if a port was found
if [ -z "$PORT" ]; then
echo "No available /dev/ttyACM* port found."
exit 1
else
echo "Detected port: $PORT"
#### Export the port as an environment variable
echo "export SERIAL_PORT=$PORT" > ~/.serial_port_env
exit 0
fi
___ end of script ____________________________________

2. Make the Script Executable

   chmod +x detect_ports.sh

3.  Load the Environment Variable in Rails

    Modify your Rails server startup process to load the detected port. Update config/application.rb or config/environments/development.rb:
___
#### Load the detected port environment variable
port_env_file = File.expand_path("~/.serial_port_env")

if File.exist?(port_env_file)
load port_env_file
puts "Using detected serial port: #{ENV['SERIAL_PORT']}"
else
puts "No detected serial port found. Using default configuration."
end
___

4. Modify Your Rails Initialization Process

Inside config/initializers/serial_config.rb, initialize your connection:

SERIAL_PORT = ENV['SERIAL_PORT'] || '/dev/ttyACM0' # Default to ttyACM0 if not found

puts "Initializing Serial Communication on #{SERIAL_PORT}"

5.  Modify Your Startup Process

Instead of manually running the script, modify your Procfile (if using Foreman) or Rails startup script:
____
####!/bin/bash
./bin/detect_ports.sh
source ~/.serial_port_env
bundle exec rails s
____
Then, make it executable:

chmod +x start_server.sh

Run it:

./start_server.sh

6. Run the Script Before Starting Rails
   You can manually run the script before starting Rails:

   ./detect_ports.sh

   source ~/.serial_port_env

   rails s
