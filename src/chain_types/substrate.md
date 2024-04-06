# Substrate Indexer Architecture

Development was originally funded by 2 grants ([1](https://github.com/w3f/Grants-Program/blob/master/applications/hybrid.md), [2](https://github.com/w3f/Grants-Program/blob/master/applications/hybrid2.md)) from the [Web3 Foundation](https://grants.web3.foundation/).

Substrate is the framework for building chains in the Polkadot ecosystem. Each Substrate chain has an event schema that changes over time. For this reason it is necessary for each chain family to have built its own Hybrid indexer that is kept current with chain runtimes.

When building a Hybrid event indexer for Substrate chains, the Rust library Hybrid Substrate is used to do most of the heavy lifting. Currently, it only supports a single schema per chain. Therefore, once the schema is updated indexing older blocks may result in missing events. This will be resolved in a future version of Hybrid Substrate.

For example, to index Polkadot blockchains (Polkadot, Kusama, Westend, Rococo) Hybrid Polkadot is used. Indexers for all Substrate need to be built, maintained and hosted.

## Indexed Keys

Hybrid Substrate has support for indexing the keys that are built-into Substrate: `AccountId`, `AccountIndex`, `BountyIndex`, `EraIndex`, `MessageId`, `PoolId`, `PreimageHash`, `ProposalHash`, `ProposalIndex`, `RefIndex`, `RegistrarIndex`, `SessionIndex`, `TipHash`.

Indexers can register additional keys to be indexed.

## Indexed Pallets

Hybrid Substrate has support for indexing all the pallets that are built-into Substrate. Indexers can write macros to index additional pallets.

## Event Variant Indexing

In addition to indexing keys, Hybrid can index event variants. This means that the index can be queried for occurrences of a specific type of event. This entails an additional database row for every event and therefore uses more storage space than any of the key indexes.

An indexer will typically expose this option via command line option.

## Queue Depth

In order to maximize the rate of block indexing, Hybrid Substrate will request multiple blocks simultaneously according to the queue depth parameter.

Currently, this only applies when indexing old blocks. Head blocks are indexed one-at-a-time. When indexing a fully synced node this is fine because head blocks arrive slowly. But when indexing a syncing node the head blocks arrive too quickly and the indexer falls behind. A future release of Hybrid Substrate will index old and head blocks using the queue.

## Example Output

Here is example output from Hybrid Polkadot indexing the Westend blockchain:

```
2024-04-06T04:04:51.826855Z  INFO hybrid_indexer: Indexing westend
2024-04-06T04:04:51.826884Z  INFO hybrid_indexer: Database path: /home/jbrown/.local/share/hybrid-indexer/westend/db
2024-04-06T04:04:51.826889Z  INFO hybrid_indexer: Database mode: LowSpace
2024-04-06T04:04:51.826892Z  INFO hybrid_indexer: Database cache capacity: 1024.00 MiB
2024-04-06T04:04:56.169676Z  INFO hybrid_indexer: Connecting to: ws://127.0.0.1:9944
2024-04-06T04:04:56.182384Z  INFO hybrid_indexer::substrate: 📇 Event variant indexing: enabled
2024-04-06T04:04:56.182454Z  INFO hybrid_indexer::websockets: Listening on: 0.0.0.0:8172
2024-04-06T04:04:56.225039Z  INFO hybrid_indexer::substrate: 📚 Indexing backwards from #20,277,820
2024-04-06T04:04:56.225822Z  INFO hybrid_indexer::substrate: 📚 Re-indexing span of blocks from #12,841,034 to #20,277,818.
2024-04-06T04:04:56.225833Z  INFO hybrid_indexer::substrate: 📚 Reason: event variants not indexed.
2024-04-06T04:04:56.225842Z  INFO hybrid_indexer::substrate: 📚 Queue depth: 64
2024-04-06T04:04:56.228018Z  INFO hybrid_indexer::substrate: Downloading metadata for spec version 1009000
2024-04-06T04:04:56.241092Z  INFO hybrid_indexer::substrate: Finished downloading metadata for spec version 1009000
2024-04-06T04:04:58.343335Z  INFO hybrid_indexer::substrate: 📚 #20,277,469: 218 blocks/sec, 2,685 events/sec, 2,685 keys/sec
2024-04-06T04:04:59.740002Z  INFO hybrid_indexer::substrate: ✨ #20,277,821: 13 events, 13 keys
2024-04-06T04:05:00.227530Z  INFO hybrid_indexer::substrate: 📚 #20,275,313: 1,086 blocks/sec, 13,583 events/sec, 13,614 keys/sec
2024-04-06T04:05:02.763669Z  INFO hybrid_indexer::substrate: 📚 #20,272,929: 940 blocks/sec, 15,064 events/sec, 18,394 keys/sec
2024-04-06T04:05:04.426178Z  INFO hybrid_indexer::substrate: 📚 #20,272,922: 4 blocks/sec, 16,659 events/sec, 33,261 keys/sec
2024-04-06T04:05:05.593444Z  INFO hybrid_indexer::substrate: ✨ #20,277,822: 13 events, 13 keys
2024-04-06T04:05:06.226993Z  INFO hybrid_indexer::substrate: 📚 #20,272,261: 369 blocks/sec, 23,423 events/sec, 41,978 keys/sec
2024-04-06T04:05:08.227001Z  INFO hybrid_indexer::substrate: 📚 #20,270,559: 856 blocks/sec, 45,057 events/sec, 79,452 keys/sec
2024-04-06T04:05:10.331457Z  INFO hybrid_indexer::substrate: 📚 #20,268,186: 1,126 blocks/sec, 26,275 events/sec, 38,673 keys/sec
2024-04-06T04:05:11.703634Z  INFO hybrid_indexer::substrate: ✨ #20,277,823: 13 events, 13 keys
2024-04-06T04:05:12.227412Z  INFO hybrid_indexer::substrate: 📚 #20,266,277: 1,011 blocks/sec, 35,308 events/sec, 57,998 keys/sec
2024-04-06T04:05:14.242257Z  INFO hybrid_indexer::substrate: 📚 #20,264,587: 832 blocks/sec, 32,157 events/sec, 53,993 keys/sec
2024-04-06T04:05:15.775867Z  INFO hybrid_indexer::substrate: ✨ #20,277,824: 13 events, 13 keys
2024-04-06T04:05:16.227287Z  INFO hybrid_indexer::substrate: 📚 #20,262,524: 1,048 blocks/sec, 25,504 events/sec, 38,078 keys/sec
2024-04-06T04:05:18.247665Z  INFO hybrid_indexer::substrate: 📚 #20,261,078: 753 blocks/sec, 33,254 events/sec, 57,056 keys/sec
2024-04-06T04:05:20.227680Z  INFO hybrid_indexer::substrate: 📚 #20,258,950: 1,054 blocks/sec, 23,478 events/sec, 33,931 keys/sec
2024-04-06T04:05:22.299554Z  INFO hybrid_indexer::substrate: 📚 #20,257,402: 722 blocks/sec, 30,677 events/sec, 52,286 keys/sec
2024-04-06T04:05:23.811687Z  INFO hybrid_indexer::substrate: ✨ #20,277,825: 13 events, 13 keys
2024-04-06T04:05:24.234355Z  INFO hybrid_indexer::substrate: 📚 #20,255,634: 919 blocks/sec, 23,820 events/sec, 36,200 keys/sec
2024-04-06T04:05:26.723002Z  INFO hybrid_indexer::substrate: 📚 #20,253,808: 729 blocks/sec, 35,103 events/sec, 61,190 keys/sec
2024-04-06T04:05:27.747424Z  INFO hybrid_indexer::substrate: ✨ #20,277,826: 13 events, 13 keys
2024-04-06T04:05:28.227545Z  INFO hybrid_indexer::substrate: 📚 #20,252,081: 1,159 blocks/sec, 17,027 events/sec, 19,702 keys/sec
```

Hybrid Substrate needs to connect to a full node with `--state-pruning` set to `archive-canonical` or `archive`. Typically, it is necessary to index a node that you control. This is because the indexer will require the node to consume resources far beyond what a public RPC endpoint is prepared to provide.

