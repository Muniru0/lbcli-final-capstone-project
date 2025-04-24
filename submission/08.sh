# what block height was this tx mined ?
# 49990a9c8e60c8cba979ece134124695ffb270a98ba39c9824e42c4dc227c7eb

BLOCK_HASH=$(bitcoin-cli -signet getrawtransaction 49990a9c8e60c8cba979ece134124695ffb270a98ba39c9824e42c4dc227c7eb true | jq -r '.blockhash')

HEIGHT=$(bitcoin-cli -signet getblock $BLOCK_HASH | jq -r '.height')

echo $HEIGHT