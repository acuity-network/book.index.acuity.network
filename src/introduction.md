# Introduction

A critical component of the decentralized web is decentralized applications (dapps). End users need a way to interact with a peer-to-peer system without relying on a centralized backend. Otherwise, [Enshittification](https://en.wikipedia.org/wiki/Enshittification) occurs.

Therefore, a blockchain dapp cannot rely on RPC servers to read chain state. They must query full nodes and verify the state using a light client.

In addition to reading chain state, dapps typically need to search historic blocks for events. For example, a wallet dapp would want to be able to display a list of balance transfers to and from the user's account.

This entails the use of an index. Much like a full node, an event index consumes significant resources and takes a lot of time to synchronize. A dapp cannot maintain its own index. It needs to query an index run by someone else and verify the results using a light client.

This is the purpose of Acuity Index. An event indexer for all chain types that can be verified cryptographically.

When a Hybrid index is queried for a specific key it will return the block number and event index of events that contain the key.

Additionally, it can return the event contents and enough information for the events to be verified by a light client. 

Acuity Index is a blockchain event indexer framework written in Rust. Currently, it can be used to build indexers for Substrate blockchains (Polkadot). In the future it will also support other types of chains such as Ethereum and Bitcoin.

Typically, when writing on-chain code (for example a smart contract or a Substrate pallet) data should only be stored in chain state when it might need to be read during execution of a subsequent transaction. This ensures that transaction fees are kept to an absolute minimum. Events should be emitted containing the data that only needs to be accessed off-chain. This data can then be indexed, either directly on the user's device or via a cloud service.
