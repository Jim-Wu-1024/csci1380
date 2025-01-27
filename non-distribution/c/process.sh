#!/bin/bash

# Convert input to a stream of non-stopword terms
# Usage: ./process.sh < input > output

# Check if the stopwords file exists
STOPWORDS_FILE="./d/stopwords.txt"
if [ ! -f "$STOPWORDS_FILE" ]; then
  echo "Error: Stopwords file '$STOPWORDS_FILE' not found."
  exit 1
fi

# Process the input:
# 1. Replace non-letter characters with spaces
# 2. Convert to lowercase
# 3. Convert to ASCII (remove non-ASCII characters)
# 4. Remove empty lines
# 5. Remove stopwords using `grep`

tr -c '[:alpha:]' ' ' |      # Replace non-letter characters with spaces
tr '[:upper:]' '[:lower:]' | # Convert to lowercase
iconv -c -t ASCII//TRANSLIT | # Convert to ASCII, removing non-ASCII characters
tr -s ' ' '\n' |             # Split words into one per line
grep -vFx -f "$STOPWORDS_FILE" | # Remove stopwords
grep -v '^$'                 # Remove empty lines