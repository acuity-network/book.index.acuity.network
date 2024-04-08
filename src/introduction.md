# Introduction

Hybrid is a blockchain event indexer framework written in Rust. Currently, it can be used to build indexers for Substrate blockchains (Polkadot). In the future it will also support other types of chains such as Ethereum and Bitcoin.

Typically, when writing on-chain code (for example a smart contract or a Substrate pallet) data should only be stored in chain state when it might need to be read during execution of a subsequent transaction. This ensures that transaction fees are kept to an absolute minimum. Events should be emitted containing the data that only needs to be accessed off-chain. This data can then be indexed, either directly on the user's device or via a cloud service.
