#!/usr/bin/env node

/*
Search the inverted index for a particular (set of) terms.
Usage: ./query.js your search terms
*/

const fs = require('fs');
const {execSync} = require('child_process');
// const path = require('path');

// Function to process the query
function query(indexFile, args) {
  // 1. Normalize, remove stopwords, and stem the query string using existing components
  const rawQuery = args.join(' '); // Combine the query arguments into a single string
  let processedQuery;

  try {
    processedQuery = execSync(`echo "${rawQuery}" | ./c/process.sh | ./c/stem.js`, {
      encoding: 'utf-8',
    }).trim();
  } catch (err) {
    console.error('Error processing query:', err.message);
    process.exit(1);
  }

  if (!processedQuery) {
    console.error('The query resulted in no valid terms after processing.');
    process.exit(1);
  }

  // Convert the processed query into a search pattern (space-separated terms)
  const searchPattern = processedQuery.replace(/\r?\n/g, ' ');

  // 2. Read the global index file and search for matches
  try {
    const indexData = fs.readFileSync(indexFile, 'utf-8');
    const lines = indexData.split('\n');

    const matchingLines = lines.filter((line) => line.includes(searchPattern));

    // 3. Print matching lines
    if (matchingLines.length > 0) {
      // console.log('Matching Lines:');
      matchingLines.forEach((line) => console.log(line));
    } else {
      console.log(`No matches found for query: "${rawQuery}"`);
    }
  } catch (err) {
    console.error('Error reading the global index file:', err.message);
    process.exit(1);
  }
}

// Get command-line arguments
const args = process.argv.slice(2);

if (args.length < 1) {
  console.error('Usage: ./query.js [query_strings...]');
  process.exit(1);
}

const indexFile = 'd/global-index.txt'; // Path to the global index file
query(indexFile, args);
