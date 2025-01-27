#!/usr/bin/env node

/*
Merge the current inverted index (assuming the right structure) with the global index file
Usage: cat input | ./merge.js global-index > output
*/

const fs = require('fs');
const readline = require('readline');

// The `compare` function is used for sorting by frequency in descending order
const compare = (a, b) => {
  if (a.freq > b.freq) return -1;
  if (a.freq < b.freq) return 1;
  return 0;
};

// Create a readline interface for reading from stdin
const rl = readline.createInterface({
  input: process.stdin,
});

// Store local index data
let localIndex = '';

// 1. Read the incoming local index data from stdin line by line
rl.on('line', (line) => {
  localIndex += line + '\n';
});

rl.on('close', () => {
  // 2. Read the global index file path from `process.argv`
  const globalIndexFile = process.argv[2];
  if (!globalIndexFile) {
    console.error('Error: Global index file path is required as an argument.');
    process.exit(1);
  }

  // Read the global index file and process the merge
  fs.readFile(globalIndexFile, 'utf8', (err, data) => {
    if (err) {
      console.error('Error reading global index file:', err);
      process.exit(1);
    }
    printMerged(data);
  });
});

// Function to merge and print the new global index
const printMerged = (globalData) => {
  // Split the data into an array of lines
  const localIndexLines = localIndex.trim().split('\n');
  const globalIndexLines = globalData.trim().split('\n');

  const local = {};
  const global = {};

  // 3. Parse the local index lines into the `local` object
  for (const line of localIndexLines) {
    const [term, freq, url] = line.split(' | ').map((part) => part.trim());
    if (term && freq && url) {
      local[term] = {url, freq: parseInt(freq, 10)};
    }
  }

  // 4. Parse the global index lines into the `global` object
  for (const line of globalIndexLines) {
    const [term, entries] = line.split(' | ').map((part) => part.trim());
    if (term && entries) {
      const urlFreqPairs = entries.split(' ').map((entry, index, array) => {
        if (index % 2 === 0) {
          // Combine `url` and `freq` as an object
          return {url: entry, freq: parseInt(array[index + 1], 10)};
        }
        return null;
      }).filter((pair) => pair); // Remove null entries
      global[term] = urlFreqPairs;
    }
  }

  // 5. Merge the local index into the global index
  for (const term in local) {
    if (global[term]) {
      // Term exists in global index: append and sort by frequency
      global[term].push(local[term]);
      global[term].sort(compare);
    } else {
      // Term doesn't exist: add it as a new entry
      global[term] = [local[term]];
    }
  }

  // 6. Print the merged index to stdout
  for (const term in global) {
    const entries = global[term]
        .map((entry) => `${entry.url} ${entry.freq}`)
        .join(' ');
    console.log(`${term} | ${entries}`);
  }
};
