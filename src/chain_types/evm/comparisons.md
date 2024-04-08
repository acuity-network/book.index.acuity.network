# Comparisons with other EVM indexers

## GhostLogs

[GhostLogs](https://ghostlogs.xyz/) is an entirely centralized service to extract more event information from EVM contracts than what is provided by the deployed smart contract.

While this can be extremely useful, it does not facilitate the creation of fully decentralized blockchain apps because the only way to access the extended events it via a query to GhostLogs servers. With Hybrid, events can be queried via a gossip protocol and the results verified via light client.

For a smart contract to rely on GhostLogs completed instead of real on-chain events (to save gas) is not recommended as the contract would then be dependent on a centralized service. We recommend using events without topics to save gas.

While GhostLogs can be used for sophisticated chain analysis, it is not open source software. You can't run it on your own hardware. There is no way to verify that the data returned is correct.

Because EVM chains typically do not have a governance mechanism, the on-chain event schema is immutable. This makes GhostLogs more useful. Substrate chains with governance can modify on-chain event schema after deployment.

## Shadow

[Shadow](https://docs.shadow.xyz/) seems largely the same as GhostLogs.
