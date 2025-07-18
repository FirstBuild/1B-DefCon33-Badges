#!/bin/bash

# Check input
if [[ -z "$1" ]]; then
    echo "Usage:"
    echo "  $0 <badge_number>"
    echo "  $0 <start_badge_number> <end_badge_number>"
    echo ""
    echo "Enter a badge number to compile a single badge, or enter a start and end badge number to compile a range of badges."
    exit 1
else
    start_num=$1
fi

if [[ -z "$2" ]]; then
    end_num=$1
else
    end_num=$2
fi

echo "Start number: $start_num"
echo "End number: $end_num"

if ! [[ "$start_num" =~ ^[0-9]+$ && "$end_num" =~ ^[0-9]+$ ]]; then
  echo "Usage:"
    echo "  $0 <badge_number>"
    echo "  $0 <start_badge_number> <end_badge_number>"
    echo ""
    echo "Enter a badge number to compile a single badge, or enter a start and end badge number to compile a range of badges."
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
      echo "Processing File: ${filename}"
      esphome compile "$filename"
    fi
  fi
done