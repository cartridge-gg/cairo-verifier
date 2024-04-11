#!/usr/bin/env zsh

calldata=$(cat)
sncast \
    --url https://starknet-sepolia.public.blastapi.io/rpc/v0_7 \
    --account testnet \
    --wait \
    invoke \
    --contract-address 0xf6246d599bfaa1dfd074f5ab17665cd12603ee9dfc137254ef077c796ced6f \
    --function verify_and_register_fact \
    --calldata $calldata
