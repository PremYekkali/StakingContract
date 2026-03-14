# Staking Smart Contract

![Solidity](https://img.shields.io/badge/solidity-0.5.7-363636?style=flat&logo=solidity)
![License](https://img.shields.io/badge/license-MIT-blue)
---

## Overview
This repository contains a Solidity-based staking contract that enables users to stake ERC20-compliant tokens and earn rewards over a fixed staking period. Rewards accrue continuously and are distributed proportionally based on stake size and time of participation, using a global yield-per-token model.


The contract fairly distributes rewards based on stake size and staking duration while supporting multiple stakes and withdrawal operations.

## Key Features
- ERC20 token staking with time-based reward distribution
- Linear reward unlocking over a predefined staking period
- Accurate per-user reward accounting using cumulative global yield per token
- Support for multiple stakes and partial withdrawals
- Automatic handling of unclaimed rewards(Accrued between stake start time and 1st stake) via a vault address

## Contract Architecture
The staking system consists of the following core components.

### Stake Token
ERC20 token deposited by users for staking

### Reward Token
ERC20 token distributed as staking rewards

### InterestData
Maintains global staking state, including total staked amount, accumulated yield per token, and last update timestamp

### Staker
Tracks individual user stake, withdrawn rewards, and buy-in rate for accurate accounting

## Reward Distribution Logic
Rewards are distributed linearly over the staking period.

Global yield per token increases based on elapsed time and total rewards available. Each staker earns rewards proportional to their stake and the time their tokens remain staked.

Earned interest is calculated as:

```
(TotalStaked × GlobalYieldPerToken)
− (StakeBuyinRate + WithdrawnToDate)
```
This ensures users cannot overearn or double-claim rewards.

### Reward Timing Behavior
If the staking period has ended, reward generation stops automatically.  
Any rewards generated after the staking window are not distributed to stakers.

## Vault Handling
If rewards are generated while no tokens are staked (e.g., before any user stakes, or if at any point the total staked amount becomes 0 due to all users unstaking), the generated reward amount is automatically transferred to the vault address. This ensures no rewards are lost and maintains proper accounting.

## Design Decisions
- Uses a global yield per token model to avoid per-user loops
- Separates stake accounting from reward claiming for flexibility
- Handles zero stake scenarios by redirecting rewards to a vault
- Supports multiple `stake` and `withdraw` actions per user without precision loss

## Core Functions

### stake
Allows users to stake tokens after approving the contract. Staking is only allowed during the active staking period.

### withdrawInterest
Allows users to claim accrued rewards without unstaking their tokens.

### withdrawStakeAndInterest
Withdraws a specified amount of staked tokens and automatically settles any pending rewards before updating balances.

### calculateInterest
Returns the current claimable reward for a user.

### updateGlobalYield
Updates the global reward distribution state based on elapsed time.

### getStatsData
Returns protocol and user-level statistics, including estimated rewards and unlocked rewards.

## Staking Lifecycle
1. Contract is deployed with staking start time, staking period, total reward, and vault address
2. Users stake tokens during the active staking window
3. Rewards accrue continuously over time till staking is active
4. Users may claim rewards independently or withdraw their stake, with rewards automatically settled during stake withdrawal
5. Undistributed rewards are transferred to the vault address, which was set during deployment.

## Read-Only Helper Functions
The contract exposes multiple view functions to help frontends and analytics tools.

- getStakerData returns user stake and withdrawn rewards
- getYieldData returns global and user yield metrics
- getStatsData returns protocol and user-level reward statistics

## Requirements
- Solidity version 0.5.7
- ERC20-compliant stake and reward tokens
- SafeMath library for arithmetic safety

## Security Notes
- Uses SafeMath for all arithmetic operations to avoid under/over flows.
- Prevents reward over-distribution via buy-in rate accounting
- Updates global state (interest and stake accounting) before modifying user balances, ensuring reward withdrawals are safe from reentrancy exploits
- Avoids negative reward calculations
- Redirects rewards to the vault when no active staking exists

## Known Limitations
- Contract does not support staking before the configured start time; any attempt to stake or withdraw rewards before stakingStartTime will revert
- Reward rate is fixed at deployment and cannot be modified
- No emergency `withdraw` mechanism is implemented for security reasons
- Solidity version is locked to 0.5.7

## Disclaimer
This contract has not been audited. So it is highly recommended that you review thoroughly before using it in production or anywhere.
