# How many new outputs were created by block 243,825?

#!/bin/bash

# OUTPUT_COUNT=442

# echo $OUTPUT_COUNT


BLOCKHASH=$(bitcoin-cli -signet getblockhash 243825)

OUTPUT_COUNT=$(bitcoin-cli -signet getblock $BLOCKHASH 2 | jq '[.tx[].vout | length] | add')


echo $OUTPUT_COUNT