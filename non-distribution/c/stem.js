#!/usr/bin/env node

/*
Convert each term to its stem.
Usage: ./stem.js <input> output
*/

const readline = require('readline');
const natural = require('natural'); // Import the natural language processing library.

// Set up readline to process input line by line.
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

// Process each line of input
rl.on('line', function(line) {
  // Split the line into words
  const words = line.split(/\s+/); // Split on whitespace.

  // Stem each word using the Porter Stemmer.
  const stemmedWords = words.map((word) => natural.PorterStemmer.stem(word));

  // Join the stemmed words into a single line and print the result.
  console.log(stemmedWords.join(' '));
});
