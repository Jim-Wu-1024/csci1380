#!/usr/bin/env node

/*
Extract all text from an HTML page.
Usage: ./getText.js <input> output
*/

const {convert} = require('html-to-text'); // Import the html-to-text library.
const readline = require('readline');

let html = '';

// Set up the readline from standard input, line by line.
const rl = readline.createInterface({
  input: process.stdin,
});

// 1. Read HTML input from standard input, Line by line.
rl.on('line', (line) => {
  html += line + '\n'; // Append each line of input to the `html` string.
});

// 2. After all input is received, use 'convert' to extract plain text.
rl.on('close', () => {
  try {
    // Convert the accumulated HTML to plain text.
    const plainText = convert(html, {
      wordwrap: 130, // Wrap text at 130 chars.
    });

    // Output the plain text to stdout
    console.log(plainText);
  } catch (error) {
    console.error('Error processing HTML: ', error.message);
    process.exit(1); // Exit with error code if conversion fails.
  }
});
