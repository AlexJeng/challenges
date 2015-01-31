#!/usr/bin/env bash -e

function read_current_time {
  local IFS=:
  read current_hour current_minute <<< "$1"
}

function read_config {
  config=`cat`
}

function calculate_hour {
  if [ "$hour_config" == "*" ]
  then
    new_hour="$current_hour"
  else
    new_hour="$hour_config"
  fi
}

function calculate_minute {
  if [ "$minute_config" == "*" ]
  then
    if [ "$new_hour" -ne "$current_hour" ]
    then
      new_minute=00
    else
      new_minute="$current_minute"
    fi
  else
    new_minute="$minute_config"
  fi
}

function calculate_day {
  if [ "$new_hour" -lt "$current_hour" ]
  then
    day=tomorrow
  else
    if [ "$new_hour" -eq "$current_hour" ]
    then
      if [ "$new_minute" -lt "$current_minute" ]
      then
        day=tomorrow
      else
        day=today
      fi
    else
      day=today
    fi
  fi
}

read_current_time $1
read_config

while read -r line
do
  minute_config=`cut -d ' ' -f 1 <<< "$line"`
  hour_config=`cut -d ' ' -f 2 <<< "$line"`
  command_config=`cut -d ' ' -f 3 <<< "$line"`

  calculate_hour
  calculate_minute
  calculate_day

  echo "$new_hour":"$new_minute" "$day" - "$command_config"
done <<< "$config"
