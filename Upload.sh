#!/bin/bash

# Check input
if [[ -z "$1" ]]; then
    start_num=0
else
    start_num=$1
fi

if [[ -z "$2" ]]; then
    end_num=$1
else
    end_num=$2
fi

if ! [[ "$start_num" =~ ^[0-9]+$ && "$end_num" =~ ^[0-9]+$ ]]; then
  echo "Both inputs must be integers."
  exit 1
fi

if (( start_num > end_num )); then
  temp=$start_num
  start_num=$end_num
  end_num=$temp
fi

shopt -s nullglob

for filename in YAMLs/1b-defcon-badge-*.yaml; do
  # Extract number from the filename (assumes format like filename-XX.yaml)
  base=$(basename "$filename" .yaml)
  num_part=$((10#${base##*-}))

  # Check if the number part is a valid integer
  if [[ "$num_part" =~ ^[0-9]+$ ]]; then
    if (( num_part >= start_num && num_part <= end_num )); then
      echo "Uploading File: ${filename}"
      read -p "Press Enter to flash ${filename} to the device..."

      # Get list of matching devices
      devices=(/dev/tty.usbmodem*)

      if [[ ${#devices[@]} -gt 0 ]]; then
        first_device="${devices[0]}"
        echo "Found device: $first_device"
      else
        echo "No matching /dev/tty.usbmodem* device found."
      fi

      esphome upload "$filename"  --device "$first_device"
    fi
  fi
done
