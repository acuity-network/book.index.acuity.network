# Introduction

Hybrid is a blockchain event indexer framework written in Rust. Currently, it can be used to build indexers for Substrate blockchains (Polkadot). In the future it will also support other types of chains such as Ethereum and Bitcoin.

Development was originally funded by 2 grants ([1](https://github.com/w3f/Grants-Program/blob/master/applications/hybrid.md), [2](https://github.com/w3f/Grants-Program/blob/master/applications/hybrid2.md)) from the [Web3 Foundation](https://grants.web3.foundation/).

Typically, when writing on-chain code (for example a smart contract or a Substrate pallet) data should only be stored in chain state when it might need to be read during execution of a subsequent transaction. This ensures that transaction fees are kept to an absolute minimum. Events should be emitted containing the data that only needs to be accessed off-chain. This data can then be indexed, either directly on the user's device or via a cloud service.

Ethereum [events](https://docs.soliditylang.org/en/latest/contracts.html#events) have a data structure called "topics". Full nodes will use a [bloom filter](https://en.wikipedia.org/wiki/Bloom_filter) for accelerated scanning of topics for specific values. This has a number of issues:

* Topics cannot be scanned by a light client
* While very space efficient, it is not as efficient to search compared to a dedicated database index
* Centralized RPC providers are very inconsistent - some will limit scans by number of blocks, others by execution time. Additionally, there is no API to determine these limits.
* While not as expensive as on-chain indexing, topics are more expensive than simply including data in events for off-chain indexing.

For these reasons Substrate does not provide "topic" functionality.
