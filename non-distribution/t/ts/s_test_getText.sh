#!/bin/bash
# This is a student test

# Input HTML
input='<h1>Title</h1><p>This is a paragraph.</p>'

# Expected output
expected='Title
This is a paragraph.'

# Run the component
output=$(echo "$input" | c/getText.js)

# Compare the output with the expected output
if [ "$output" == "$expected" ]; then
  echo "s_test_getText.sh: Passed"
else
  echo "s_test_getText.sh: Failed"
  echo "Expected:"
  echo "$expected"
  echo "Got:"
  echo "$output"
  exit 1
fi