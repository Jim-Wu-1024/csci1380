#!/bin/bash
# This is a student test

# Local index input
local='apple | 8 | url1
bee | 3 | url2'

# Global index file
global='apple | url3 2'

# Expected output
expected='apple | url1 8 url3 2
bee | url2 3'

# Create a temporary global index file
global_file=$(mktemp)
echo "$global" > "$global_file"

# Run the component
output=$(echo "$local" | c/merge.js "$global_file")

# Compare the output with the expected output
if [ "$output" == "$expected" ]; then
  echo "s_test_merge.sh: Passed"
else
  echo "s_test_merge.sh: Failed"
  echo "Expected:"
  echo "$expected"
  echo "Got:"
  echo "$output"
  exit 1
fi

# Clean up
rm "$global_file"