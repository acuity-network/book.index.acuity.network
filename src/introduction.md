# Introduction

The Web is in decline due to [enshittification](https://en.wikipedia.org/wiki/Enshittification), a term popularized by Cory Doctorow. Although Doctorow does not know this, open source decentralized applications (dapps) reaching state consensus via the blockchain is critical to overcome this problem and for the Web to succeed in its mission to save humanity.

The underlying reason why enshittification occurs is because popular web platforms are owned and controlled by centralized organizations that ultimately do not do what is best for their users. Dapps on the other hand are either fully autonomous (never change), or are governed by decentralized autonomous organizations (DAOs).

However, blockchain dapps have a number of major issues that prevents them from usurping the centralized platforms. Acuity Index is the solution to one of these problems. Another critical problem Acuity is solving is debasement.

Explain more why dapps are good

## The Problem

Dapps need to write to and query blockchain state, events (logs) and decentralized filesystems such as [IPFS](https://ipfs.tech/). Current state can be read and modified on-chain by extrinsics (transactions). Historic state can only be read off-chain. Events can be written by extrinsics, but only read off-chain. Files on IPFS can only be written and read off-chain, but a cryptographic hash of the file can be stored on-chain in state or an event.

|               | Read         | Write     | Modify   | 
|---------------|--------------|-----------|----------|
|Current State  | on/off-chain | on-chain  | on-chain |
|Historic State | off-chain    |           |          |
|Events         | off-chain    | on-chain  |          |
|IPFS           | off-chain    | off-chain |          |

Writing data to an event is considerably cheaper than writing it to state. IPFS is free, except for storage and bandwidth costs to keep a file [pinned](https://docs.ipfs.tech/how-to/pin-files/).

For example, the balance of an address must be stored in state. This is necessary so that it can be checked that an account has enough balance for a transfer. The record of balance transfers is stored in events to reduce transaction fees. A user's public avatar and blog posts would be stored on IPFS with only the hashes stored in events.

Dapps need to be able to search decentralized data. For example, a wallet dapp needs to be able to find every balance transfer event either from or to the user's address. A map dapp needs to perform geospatial search on GPS coordinates stored in events. A feed reader dapp needs to be able to perform full-text search stored on IPFS.

Currently, Ethereum dapps will typically use the Metamask browser extension or similar to query a centralized RPC provider to read the state, search for events and broadcast transactions.

This arrangement has a number of issues that undermines the decentralized nature of dapps:

### Incorrect or missing data

The dapp typically trusts the RPC provider to return correct query results. In theory, the results may be incorrect or incomplete. This could be used to trick the user into doing something self-harming.

### Query limits

Event searching is critical for many dapps, but EVM RPC providers (especially free ones) have various query limits:

* max blocks scanned per query
* earliest scannable block
* max execution time
* event searching disabled completely

Additionally, there is no API for a dapp to query what an RPC provider's limits are. If a dapp exceeds limits it will receive a non-semantic error message that can only be presented to the user. This makes for an unacceptable user experience.

### Slow queries

The event indexing built into Ethereum uses a form of accelerated scanning using bloom filters. This is considerably slower to query than a real database index and uses more resources.

The provider may take a long time to respond to a query, giving the user a poor experience.

### Unavailability

There are various reasons why an RPC provider may not provide query results to a dapp:

* technical problems - 100% uptime is impossible for a centralized service
* geoblocking - social and political pressure can result in queries from certain physical locations being blocked
* KYC requirements - the provider may be required by law to obtain the real-world identity of the user of the dapp
* lack of payment

### No standard payment API

There are various services that offer paid access to high quality nodes, but there is no standard for how to pay for them. This creates a lot of friction for users that want to query multiple chains and switch between different providers.

### Tracking

The provider could be logging data of which IP addresses and real-world identities are making which queries. 

### Encourages dapp backends

A very attractive solution to the issues with RPC providers is for dapp developers to build a centralized backend that will do everything required in a very efficient way. Unfortunately, this undermines many of the advantages of having a dapp.

### More expensive transactions

Because searching for logs is unreliable, architects of smart contracts and Substrate pallets may decide to store data in state where it can be more easily retrieved. This is considerably more expensive. The additional use of block-space will also make all other transactions on the chain more expensive.

### Lack of extensibility



## The Solution

One solution is for the user to run their own full node for each chain that is being queried, but this is almost never practical. Running a full node typically requires terabytes of storage & bandwidth and can take weeks to become fully synchronized.

Dapps can query full nodes and use a light client to cryptographically verify the results are correct. In fact, Ethereum and Substrate are both introducing improvements to their light client technology. This solves the problem of incorrect data.

However, this does not solve all the other problems.

An Acuity Index node runs alongside the node it is indexing. In its simplest implementation it maintains an index of block number and event index for each key, for example account id.

For EVM-based chains such as Ethereum it needs to know the schema for each smart contract it is indexing. For Substrate-based chains it needs to know the schema of the runtime.

### High performance

Acuity Index uses the [Sled](http://sled.rs/) key value database to create an event index that can handle very large query throughput. It is considerably more efficient than EVM indexed topics.

Clients can request to either receive just the block number and event index of each event, or also receive the event data.

Event data can then be verified as correct using the underlying light client of the chain.

For maximum performance, the index can store the event data. Alternatively, it can retrieve this from the full node as required to save space.

### Well-defined query accounting

An index node can track cumulative query weight, either by authenticated account, or by virtual account (ip address).

### Standardized payment API

create fee market for indexes

### Privacy

If the user is accessing an index node for free, they will need to make a direct connection to the index so it can monitor and limit use based on IP address. This is not good for privacy.

If the user is paying for their queries, then they can also obfuscate their identity by querying via tor or mixnet and paying via anonymous means.

### Extensible

full-text, geospatial, etc

### Lower on-chain transaction fees


--

Optionally it can index event variants. For example, the index could return a list of all balance transfers. This makes the index much larger.

This entails the use of an index. Much like a full node, an event index consumes significant resources and takes a lot of time to synchronize. A dapp cannot maintain its own index. It needs to query an index run by someone else and verify the results using a light client.

This is the purpose of Acuity Index. An event indexer for all chain types that can be verified cryptographically.

When a Hybrid index is queried for a specific key it will return the block number and event index of events that contain the key.

Additionally, it can return the event contents and enough information for the events to be verified by a light client. 

Acuity Index is a blockchain event indexer framework written in Rust. Currently, it can be used to build indexers for Substrate blockchains (Polkadot). In the future it will also support other types of chains such as Ethereum and Bitcoin.

Typically, when writing on-chain code (for example a smart contract or a Substrate pallet) data should only be stored in chain state when it might need to be read during execution of a subsequent transaction. This ensures that transaction fees are kept to an absolute minimum. Events should be emitted containing the data that only needs to be accessed off-chain. This data can then be indexed, either directly on the user's device or via a cloud service.
