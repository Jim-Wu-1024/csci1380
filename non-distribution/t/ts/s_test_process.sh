#!/bin/bash
# This is a student test

# Create a temporary stopwords file for testing
STOPWORDS_FILE="./d/stopwords.txt"
mkdir -p ./d
echo -e "the\nis\nand\nof\nto\nin\nthat\nit" > "$STOPWORDS_FILE"

# Test Case 1: Normal Input
input1="The quick brown fox jumps over the lazy dog."
expected1="quick
brown
fox
jumps
lazy
dog"

output1=$(echo "$input1" | c/process.sh)
if [ "$output1" == "$expected1" ]; then
  echo "Test Case 1: Passed"
else
  echo "Test Case 1: Failed"
  echo "Expected:"
  echo "$expected1"
  echo "Got:"
  echo "$output1"
  exit 1
fi

# Test Case 2: Input with non-ASCII characters
input2="Résumé: The café has a unique flavor."
expected2="resume
cafe
unique
flavor"

output2=$(echo "$input2" | c/process.sh)
if [ "$output2" == "$expected2" ]; then
  echo "Test Case 2: Passed"
else
  echo "Test Case 2: Failed"
  echo "Expected:"
  echo "$expected2"
  echo "Got:"
  echo "$output2"
  exit 1
fi

# Test Case 3: Input with only stopwords
input3="the is and of to in that it"
expected3=""

output3=$(echo "$input3" | c/process.sh)
if [ "$output3" == "$expected3" ]; then
  echo "Test Case 3: Passed"
else
  echo "Test Case 3: Failed"
  echo "Expected:"
  echo "(empty)"
  echo "Got:"
  echo "$output3"
  exit 1
fi

# Test Case 4: Empty Input
input4=""
expected4=""

output4=$(echo "$input4" | c/process.sh)
if [ "$output4" == "$expected4" ]; then
  echo "Test Case 4: Passed"
else
  echo "Test Case 4: Failed"
  echo "Expected:"
  echo "(empty)"
  echo "Got:"
  echo "$output4"
  exit 1
fi

# Clean up
rm -f "$STOPWORDS_FILE"