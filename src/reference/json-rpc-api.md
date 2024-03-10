# JSON-RPC API

## Types

### Bytes32HexString

"0x0000000000000000000000000000000000000000000000000000000000000000"

### Event

```json
{
  "blockNumber": Number,
  "eventIndex": Number
}
```

### EventMeta

```json
{
  "index": Number,
  "name": String
}
```

### Variant

```json
{
  "index": Number,
  "name": String,
  "events": EventMeta
}
```

### Span

```json
{
  "start": Number,
  "end": Number
}
```

### SubstrateKey

```json
{
  "type": "AccountId",
  "value": Bytes32HexString
}
```

```json
{
  "type": "AccountIndex",
  "value": Number
}
```

```json
{
  "type": "BountyIndex",
  "value": Number
}
```

```json
{
  "type": "EraIndex",
  "value": Number
}
```

```json
{
  "type": "MessageId",
  "value": Bytes32HexString
}
```

```json
{
  "type": "PoolId",
  "value": Number
}
```

```json
{
  "type": "PreimageHash",
  "value": Bytes32HexString
}
```

```json
{
  "type": "ProposalHash",
  "value": Bytes32HexString
}
```

```json
{
  "type": "ProposalIndex",
  "value": Number
}
```

```json
{
  "type": "RefIndex",
  "value": Number
}
```

```json
{
  "type": "RegistrarIndex",
  "value": Number
}
```

```json
{
  "type": "SessionIndex",
  "value": Number
}
```

```json
{
  "type": "TipHash",
  "value": Bytes32HexString
}
```

### ChainKey

Chain specific keys defined by chain indexer implementation.

### Key

```json
{
  "type": "Variant",
  "value": [Number, Number]
}
```

```json
{
  "type": "Substrate",
  "value": SubstrateKey
}
```

```json
{
  "type": "Chain",
  "value": ChainKey
}
```

## Request

### Status

```json
{
  "type": "Status"
}
```

### Subscribe Status

```json
{
  "type": "SubscribeStatus"
}
```

### Unsubscribe Status

```json
{
  "type": "UnsubscribeStatus"
}
```

### Variants

```json
{
  "type": "Variants"
}
```

### Get Events

```json
{
  "type": "GetEvents",
  "key": Key
}
```

### Subscribe Events

```json
{
  "type": "SubscribeEvents",
  "key": Key
}
```

### Unsubscribe Events

```json
{
  "type": "UnsubscribeEvents",
  "key": Key
}
```

### Size On Disk

```json
{
  "type": "SizeOnDisk"
}
```

## Response

### Status
    
```json
{
  "type": "Status",
  "data": [Span, ...]
}
```

### Variants

```json
{
  "type": "Variants",
  "data": [Variant, ...]
}
````

### Events

```json
{
  "type": "Events",
  "key": Key,
  "data": [Event, ...]
}
````

### Subscribed

```json
{
  "type": "Subscribed"
}
````

### Unsubscribed

```json
{
  "type": "Unsubscribed"
}
````

### Size On Disk

```json
{
  "type": "SizeOnDisk",
  "data": Number
}
````
