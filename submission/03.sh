# Which tx in block 216,351 spends the coinbase output of block 216,128?

# 1. Get the coinbase TXID of block 216,128
COINBASE_TXID=$(bitcoin-cli -signet getblock $(bitcoin-cli getblockhash 216128) | jq -r '.tx[0]')

# 2. Get the block hash of block 216,351
BLOCK_HASH=$(bitcoin-cli -signet getblockhash 216351)

# 3. Search transactions in block 216,351 for any input spending the coinbase output
TX=$(bitcoin-cli  -signet getblock $BLOCK_HASH 2 | jq -r --arg COINBASE "$COINBASE_TXID" '.tx[] | select(.vin[].txid == $COINBASE) | .txid')


echo $TX