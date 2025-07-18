#!/bin/bash

for filename in *.yaml; do
  if [[ -f "$filename" ]]; then
    echo "Processing file: $filename"
    esphome compile "$filename"

    if [[ $? -ne 0 ]]; then
      echo ""
      echo "Error compiling $filename"
      exit 1
    else
      echo ""
      echo "Successfully compiled $filename"
    fi
  fi
done