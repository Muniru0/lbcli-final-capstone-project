# How many satoshis did this transaction pay for fee?: b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb
#!/bin/bash

TXID="b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb"

# Get transaction details
TX=$(bitcoin-cli -signet getrawtransaction $TXID true)

# Sum of outputs
OUTPUT_SUM=$(echo "$TX" | jq '[.vout[].value] | add')

# Sum of inputs
INPUT_SUM=0
INPUTS=$(echo "$TX" | jq -r '.vin[] | @base64')

for input in $INPUTS; do
  _jq() {
    echo "$input" | base64 --decode | jq -r "$1"
  }

  PREV_TXID=$(_jq '.txid')
  VOUT_INDEX=$(_jq '.vout')

  # Fetch the previous transaction (not gettxout)
  PREV_TX=$(bitcoin-cli -signet getrawtransaction "$PREV_TXID" true)
  VALUE=$(echo "$PREV_TX" | jq -r ".vout[$VOUT_INDEX].value")

  INPUT_SUM=$(echo "$INPUT_SUM + $VALUE" | bc)
done

# Calculate fee in BTC
FEE=$(echo "$INPUT_SUM - $OUTPUT_SUM" | bc)

# Convert to satoshis
FEE_SATS=$(echo "$FEE * 100000000" | bc | awk '{print int($1)}')

echo $FEE_SATS
