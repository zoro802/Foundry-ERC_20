# Foundry ERC20
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [Quickstart](#quickstart)
    - [Optional Gitpod](#optional-gitpod)
- [Usage](#usage)
  - [OpenZeppelin](#openzeppelin)
    - [Installing OpenZeppelin Contracts Package](#installing-openzeppelin-contracts-package)
  - [Start a local node](#start-a-local-node)
  - [Deploy](#deploy)
  - [Deploy - Other Network](#deploy---other-network)
  - [Testing](#testing)
    - [Test Coverage](#test-coverage)
- [Deployment to a testnet or mainnet](#deployment-to-a-testnet-or-mainnet)
  - [Scripts](#scripts)
  - [Estimate gas](#estimate-gas)
- [Formatting](#formatting)
- [Thank you!](#thank-you)

# Getting Started

## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [foundry](https://getfoundry.sh/)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z)`


## Quickstart

```
git clone https://github.com/PatrickAlphaC/foundry-erc20-cu
cd foundry-erc20-cu
forge install 
forge build
```

### Optional Gitpod

If you can't or don't want to run and install locally, you can work with this repo in Gitpod. If you do this, you can skip the `clone this repo` part.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#github.com/PatrickAlphaC/foundry-erc20-cu)

# Usage

## OpenZeppelin

[OpenZeppelin Contracts Docs](https://docs.openzeppelin.com/contracts/4.x/)
<br><br>
[OpenZeppelin GitHub Repo](https://github.com/OpenZeppelin/openzeppelin-contracts)
<br>

### Installing OpenZeppelin Contracts Package

```bash
forge install OpenZeppelin/openzeppelin-contracts --no-commit
```

## Start a local node

```
make anvil
```

## Deploy

This will default to your local node. You need to have it running in another terminal in order for it to deploy.

```
make deploy
```

## Deploy - Other Network

[See below](#deployment-to-a-testnet-or-mainnet)

## Testing

We talk about 4 test tiers in the video. 

1. Unit
2. Integration
3. Forked
4. Staging

This repo we cover #1 and #3. 

```
forge test
```

or 

```
forge test --fork-url $SEPOLIA_RPC_URL
```

### Test Coverage

```
forge coverage
```


# Deployment to a testnet or mainnet

1. Setup environment variables

You'll want to set your `SEPOLIA_RPC_URL` and `PRIVATE_KEY` as environment variables. You can add them to a `.env` file, similar to what you see in `.env.example`.

- `PRIVATE_KEY`: The private key of your account (like from [metamask](https://metamask.io/)). **NOTE:** FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT.
  - You can [learn how to export it here](https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-Export-an-Account-Private-Key).
- `SEPOLIA_RPC_URL`: This is url of the sepolia testnet node you're working with. You can get setup with one for free from [Alchemy](https://alchemy.com/?a=673c802981)

Optionally, add your `ETHERSCAN_API_KEY` if you want to verify your contract on [Etherscan](https://etherscan.io/).

1. Get testnet ETH

Head over to [faucets.chain.link](https://faucets.chain.link/) and get some testnet ETH. You should see the ETH show up in your metamask.

2. Deploy

```
make deploy ARGS="--network sepolia"
```


## Scripts

After deploy to a testnet or local net, you can run the scripts. 

Using cast deployed locally example: 

```
cast send <ERC20_CONTRACT_ADDRESS> "transfer()"  --value 0.1ether --private-key <PRIVATE_KEY> --rpc-url $SEPOLIA_RPC_URL
```

or, to create a ChainlinkVRF Subscription:

```
make createSubscription ARGS="--network sepolia"
```


## Estimate gas

You can estimate how much gas things cost by running:

```
forge snapshot
```

And you'll see and output file called `.gas-snapshot`


# Formatting


To run code formatting:
```
forge fmt
```


## Acknowledgments

This project was inspired by a YouTube tutorial by Patrick Collins (Cyfrin). Special thanks to Patrick for his clear and comprehensive guidance, which made learning smart contract development accessible and engaging.

**What I Learned**:
- **Code**:
  - How to create an ERC-20 token smart contract from scratch, including defining key functions such as `balanceOf`, `transfer`, `transferFrom`, and `approve`.
  - Implementing a constructor to initialize the token with a name, symbol, and initial supply, and using `_mint` to allocate tokens to the deployer.
  - Writing secure and efficient Solidity code, addressing issues like proper handling of token decimals and ensuring compliance with the ERC-20 standard.
  - Using Foundry for testing smart contracts, including writing test cases to verify token functionality and handling edge cases like insufficient balance transfers.

- **Libraries**:
  - Utilized the **OpenZeppelin** library to implement a secure and standard-compliant ERC-20 token, leveraging functions like `_mint`, `transfer`, and `approve` to avoid common vulnerabilities.
  - Learned how to import and extend OpenZeppelin's `ERC20` contract to create a custom token ("zoro Token" with symbol "ZORO").
  - Gained familiarity with OpenZeppelin's documentation and best practices for secure smart contract development.

- **Key Functions**:
  - **`balanceOf`**: Learned how to retrieve the token balance of any address, enabling balance tracking for users.
  - **`transfer`**: Understood how to enable users to send tokens directly to others, including safety checks for sufficient balance.
  - **`transferFrom`**: Mastered the delegation mechanism, allowing a third party to transfer tokens on behalf of the owner within an approved allowance.
  - **`approve`**: Learned to authorize another address to spend a specific amount of tokens, critical for interactions with DeFi protocols and other smart contracts.

Tutorial link: [https://youtu.be/sas02qSFZ74?si=iMnbH4_6xPyvrd-m]