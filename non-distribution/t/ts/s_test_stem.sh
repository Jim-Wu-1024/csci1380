#!/bin/bash
# This is a student test

# Input words
input='running jumped happily'

# Expected output
expected='run
jump
happili'

# Run the component
output=$(echo "$input" | c/stem.js)

# Compare the output with the expected output
if [ "$output" == "$expected" ]; then
  echo "s_test_stem.sh: Passed"
else
  echo "s_test_stem.sh: Failed"
  echo "Expected:"
  echo "$expected"
  echo "Got:"
  echo "$output"
  exit 1
fi