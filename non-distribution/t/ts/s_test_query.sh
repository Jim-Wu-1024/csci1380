#!/bin/bash
# This is a student test for query.js

# Global index content
global='apple | url1 8 url2 3
bee | url3 5
cherry | url4 2 url5 1'

# Test Case 1: Query for a single existing term
query1='apple'
expected1='apple | url1 8 url2 3'

# Test Case 2: Query for a single term not in the global index
query2='nonexistent'
expected2='No matches found for query: "nonexistent"'

# Test Case 3: Query for another single existing term
query3='bee'
expected3='bee | url3 5'

# Test Case 4: Query for a term with multiple URLs and different frequencies
query4='cherry'
expected4='cherry | url4 2 url5 1'

# Create a temporary global index file
global_file=$(mktemp)
echo "$global" > "$global_file"

# Run each test case
run_test() {
  query=$1
  expected=$2
  test_name=$3

  output=$(c/query.js "$query" < "$global_file")

  if [ "$output" == "$expected" ]; then
    echo "$test_name: Passed"
  else
    echo "$test_name: Failed"
    echo "Expected:"
    echo "$expected"
    echo "Got:"
    echo "$output"
    exit 1
  fi
}

# Execute test cases
run_test "$query1" "$expected1" "Test Case 1: Query for apple"
run_test "$query2" "$expected2" "Test Case 2: Query for nonexistent term"
run_test "$query3" "$expected3" "Test Case 3: Query for bee"
run_test "$query4" "$expected4" "Test Case 4: Query for cherry"

# Clean up
rm "$global_file"
