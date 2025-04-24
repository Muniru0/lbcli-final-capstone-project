# what is the coinbase tx in this block 243,834

# Get block hash
BLOCK_HASH=$(bitcoin-cli -signet getblockhash 243834)

# Get block details with transaction IDs
TXID=$(bitcoin-cli -signet getblock $BLOCK_HASH | jq -r '.tx[0]')

echo $TXID