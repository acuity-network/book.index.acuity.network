# Introduction

The Web is in decline due to [enshittification](https://en.wikipedia.org/wiki/Enshittification), a term popularized by Cory Doctorow. Although Doctorow does not know this, open source decentralized applications (dapps) reaching state consensus via the blockchain is critical to overcome this problem and for the Web to succeed in its mission to save humanity.

The underlying reason why enshittification occurs is because popular web platforms are owned and controlled by centralized organizations that ultimately do not do what is best for their users. Dapps on the other hand are either fully autonomous, or controlled by decentralized organizations (DAOs).

However, blockchain dapps have a number of major issues that prevents them from usurping the centralized platforms. Acuity Index is the solution to one of these problems. Another critical problem Acuity is solving is debasement.

## The Problem

Dapps need to query blockchain state and events (logs). Current state can be read and modified by subsequent extrinsics (transactions). Historic state can be read externally. Events can be written by extrinsics, but only read externally.

For example, the balance of an address is stored in state, but the record of balance transfers is stored in events. Writing data to an event is considerably cheaper than writing it to state.

Additionally, dapps need to be able to search events. For example, a wallet dapp needs to be able to find every balance transfer event either from or to the user's address. There may be some circumstances where it is also useful to search state.

A critical component of the decentralized web is decentralized applications (dapps). End users need a way to interact with a peer-to-peer system without relying on a centralized backend. Otherwise, [Enshittification](https://en.wikipedia.org/wiki/Enshittification) occurs.

Reading chain state from an RPC server not controlled by the user has a number of issues:

* the data could be incorrect
* the server may not be functioning
* the server may be slow to return data
* the server may have limits, e.g. max query time, max block scanable, block scanning available
* geoblocking - some RPC providers block access from certain countries
* the server could be logging data of which ip addresses are making which queries

One solution is for the user to run their own full node for each chain that is being queried, but this is almost never practical. Running a full node typically requires terabytes of data bandwidth and can take days to become synced.

Therefore, a blockchain dapp cannot trust an RPC server not controlled by the user to read chain state. They must query full nodes and verify the state using a light client.

In addition to reading chain state, dapps typically need to search historic blocks for events. For example, a wallet dapp would want to be able to display a list of balance transfers to and from the user's account.

This entails the use of an index. Much like a full node, an event index consumes significant resources and takes a lot of time to synchronize. A dapp cannot maintain its own index. It needs to query an index run by someone else and verify the results using a light client.

This is the purpose of Acuity Index. An event indexer for all chain types that can be verified cryptographically.

When a Hybrid index is queried for a specific key it will return the block number and event index of events that contain the key.

Additionally, it can return the event contents and enough information for the events to be verified by a light client. 

Acuity Index is a blockchain event indexer framework written in Rust. Currently, it can be used to build indexers for Substrate blockchains (Polkadot). In the future it will also support other types of chains such as Ethereum and Bitcoin.

Typically, when writing on-chain code (for example a smart contract or a Substrate pallet) data should only be stored in chain state when it might need to be read during execution of a subsequent transaction. This ensures that transaction fees are kept to an absolute minimum. Events should be emitted containing the data that only needs to be accessed off-chain. This data can then be indexed, either directly on the user's device or via a cloud service.
