# Staking Smart Contract

## Overview
This repository contains a Solidity based staking contract that allows users to stake ERC20 tokens and earn rewards over a fixed staking period. Rewards are distributed linearly over time and calculated using a global yield per token mechanism.

The contract fairly distributes rewards based on stake size and staking duration while supporting multiple stake and withdrawal operations.

## Key Features
- ERC20 token staking with time based reward distribution
- Linear reward unlocking over a predefined staking period
- Accurate per user reward accounting using global yield per token
- Support for multiple stakes and partial withdrawals
- Automatic handling of unclaimed rewards via a vault address