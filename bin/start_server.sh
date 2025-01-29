#!/bin/bash
./bin/detect_ports.sh
source ~/.serial_port_env
bundle exec rails s
