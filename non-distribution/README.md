# M0: Setup & Centralized Computing

## Summary

My implementation consists of **6 key components**:
1. **`stem.js`**: Stems words to their root form.
2. **`getText.js`**: Extracts text from HTML streams.
3. **`getURLs.js`**: Extracts and validates URLs.
4. **`process.sh`**: Normalizes text (e.g., lowercase, removes stopwords).
5. **`merge.js`**: Merges page-level indices into the global inverted index.
6. **`query.js`**: Handles search queries and ranks results.

The most challenging aspects were:
1. **Integrating the entire pipeline**: Ensuring seamless communication between all components (e.g., stemming, processing, indexing) and handling edge cases like malformed HTML or invalid URLs.
2. **Implementing `query.js`**: This required processing raw user input (normalization, stopword removal, stemming), matching search terms against the global index, and handling scenarios where no matches are found. Combining shell and Node.js for query processing added additional complexity, especially around error handling and performance optimization.

---

## Correctness & Performance Characterization

### Correctness  
To characterize correctness, I developed 10 tests that cover the following cases:  

- **URL Extraction**:
  - Extracting all valid absolute URLs from HTML content.
  - Resolving relative URLs into absolute URLs based on the base URL of the page.
  - Ignoring malformed or invalid URLs in the input HTML.

- **Query Processor**:
  - Querying for a single existing term (e.g., "apple") and returning correct results.
  - Querying for a term not present in the global index (e.g., "nonexistent") and returning appropriate error messages.
  - Querying for terms with multiple URLs and varying frequencies to ensure accurate ranking.
  - Handling queries with unexpected input formats or empty queries.

- **Text Processing**:
  - Removing stopwords and normalizing input (e.g., converting text to lowercase and removing noise).
  - Correctly processing non-ASCII characters (e.g., accents in "Résumé" → "resume").
  - Handling input with only stopwords, ensuring no irrelevant terms are included in the output.
  - Processing empty input gracefully without errors. 

### Performance  

#### **Local Development Environment (`dev`)**
- **Crawler**: Processes **0.96 pages/sec** on a standard dataset.
- **Indexer**: Indexes **0.96 pages/sec**, matching the crawling speed.
- **Query Processor**: Handles **20.53 queries/sec** with an average response time under typical load.

#### **AWS Cloud Environment (`aws`)**
- **Crawler**: Processes **0.97 pages/sec**, demonstrating a slight performance improvement due to better hardware and network conditions.
- **Indexer**: Indexes **0.96 pages/sec**, maintaining consistency with the local environment.
- **Query Processor**: Handles **20.13 queries/sec**, slightly lower than the local environment due to possible network latency.

#### **Gradescope Environment (`gs`)**
- **Crawler**: **All test cases passed**, confirming correctness.
- **Indexer**: **All test cases passed**, confirming correctness.
- **Query Processor**: **All test cases passed**, confirming correctness.

### Observations
- **Local vs. AWS**: The AWS cloud environment shows marginal improvements in crawling and indexing speed due to optimized hardware but slightly lower query throughput likely due to network-related overhead.
- **Gradescope**: While performance metrics are not available for Gradescope, all test cases passed, ensuring the correctness of the implementation.

---

## Wild Guess

I estimate that building a fully distributed and scalable version of the search engine will require **1,800–2,000 lines of code**. This estimate is based on:

- **Adding distributed crawling** using message queues.
- **Implementing load balancing** with AWS Elastic Load Balancer.
- **Enhancing fault tolerance and redundancy**, such as database replication for the inverted index.
- **Extending query ranking** with advanced algorithms.

This additional complexity and distributed architecture will necessitate extra lines of code for infrastructure, APIs, and error handling.

