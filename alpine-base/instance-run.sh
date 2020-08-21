#!/bin/bash

START_CMD="bin/catalina.sh"
exec $START_CMD &

tail -f /dev/null