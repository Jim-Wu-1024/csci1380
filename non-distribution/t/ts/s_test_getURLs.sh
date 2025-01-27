#!/bin/bash
# This is a student test

# Input HTML
input='<a href="https://example.com/page1">Page 1</a><a href="/page2">Page 2</a>'

# Expected output
expected='https://example.com/page1
https://example.com/page2'

# Run the component
output=$(echo "$input" | c/getURLs.js https://example.com)

# Compare the output with the expected output
if [ "$output" == "$expected" ]; then
  echo "s_test_getURLs.sh: Passed"
else
  echo "s_test_getURLs.sh: Failed"
  echo "Expected:"
  echo "$expected"
  echo "Got:"
  echo "$output"
  exit 1
fi