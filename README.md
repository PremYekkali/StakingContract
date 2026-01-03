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

## Contract Architecture
The system consists of the following core components.

### Stake Token
ERC20 token deposited by users for staking

### Reward Token
ERC20 token distributed as staking rewards

### InterestData
Tracks global staking state including total staked amount and accumulated yield per token

### Staker
Tracks individual user stake, withdrawn rewards, and buy in rate for accurate accounting

## Reward Distribution Logic
Rewards are distributed linearly over the staking period.

Global yield per token increases based on elapsed time and total rewards available. Each staker earns rewards proportional to their stake and the time their tokens remain staked.

Earned interest is calculated as:

(TotalStaked × GlobalYieldPerToken)
− (StakeBuyinRate + WithdrawnToDate)

This ensures users cannot over earn or double claim rewards.

## Core Functions

### stake
Allows users to stake tokens after approving the contract. Staking is only allowed during the active staking period.

### withdrawInterest
Allows users to claim accrued rewards without unstaking their tokens.

### withdrawStakeAndInterest
Withdraws both the staked tokens and any accrued rewards.

### calculateInterest
Returns the current claimable reward for a user.

### updateGlobalYield
Updates global reward distribution state based on elapsed time.

### getStatsData
Returns protocol and user level statistics including estimated rewards and unlocked rewards.

