# EVM

Ethereum [events](https://docs.soliditylang.org/en/latest/contracts.html#events) have a data structure called "topics". Full nodes will use a [bloom filter](https://en.wikipedia.org/wiki/Bloom_filter) for accelerated scanning of topics for specific values. This has a number of issues:

* Topics cannot be scanned by a light client
* While very space efficient, it is not as efficient to search compared to a dedicated database index
* Centralized RPC providers are very inconsistent - some will limit scans by number of blocks, others by execution time. Additionally, there is no API to determine these limits.
* While not as expensive as on-chain indexing, topics are more expensive than simply including data in events for off-chain indexing.

For these reasons Substrate does not provide "topic" functionality.
