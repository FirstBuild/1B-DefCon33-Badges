#!/bin/bash

for filename in YAMLs/1b-defcon-badge-*.yaml; do
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