#!/bin/bash

for filename in *.yaml; do
  if [[ -f "$filename" ]]; then
    echo "Processing file: $filename"
    esphome upload "$filename"

    if [[ $? -ne 0 ]]; then
      echo ""
      echo "Error uploading $filename"
      exit 1
    else
      echo ""
      echo "Successfully uploaded $filename"
    fi
  fi
done