# OurToken ERC20 Deployment Project

This project demonstrates the creation and deployment of a simple ERC20 token using Foundry and OpenZeppelin Contracts.

## Project Overview

- **`src/OurToken.sol`**:  
  Implements the `OurToken` ERC20 token contract, inheriting from OpenZeppelin's secure and audited ERC20 implementation. The token is initialized with a fixed initial supply minted to the deployer.

- **`script/DeployOurToken.s.sol`**:  
  A Foundry deployment script that inherits from `forge-std`'s `Script` contract. It defines the `run()` entry point which deploys the `OurToken` contract with a preset initial supply. The script leverages Foundry's broadcasting functionality to send transactions to the blockchain.

- **OpenZeppelin Contracts Library**:  
  The project uses the widely adopted [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts) library for standard and secure implementations of ERC20 tokens and other utilities.

## Getting Started

### Prerequisites

- Install [Foundry](https://foundry.paradigm.xyz/) (forge and cast CLI tools).
- Ensure network RPC endpoints are configured for deployment (local, testnet, or mainnet).

### Compiling

```bash
forge build
```

### Deploying the Token

Deploy the `OurToken` contract using the Foundry script:

```bash
forge script script/DeployOurToken.s.sol --broadcast --rpc-url <RPC_URL>
```

Replace `<RPC_URL>` with your desired Ethereum-compatible network RPC URL.

## Token Contract Details

- The token has a name: "OurToken" and symbol: "OT".
- Initial supply is set to `100 ether` units (100 tokens with 18 decimals).
- The entire initial supply is minted to the deployer's address.

## Project Structure

```
.
├── src/
│   └── OurToken.sol         # ERC20 Token contract
├── script/
│   └── DeployOurToken.s.sol # Foundry deployment script
├── lib/
│   └── openzeppelin-contracts/  # External OpenZeppelin contracts library
├── README.md                # Project documentation
├── foundry.toml             # Foundry configuration
```

## Makefile Commands

This project includes a `Makefile` with convenient commands to manage development and deployment tasks:

- `make clean`: Clean the build artifacts.
- `make install`: Install dependencies including forge-std and OpenZeppelin libraries.
- `make update`: Update installed dependencies.
- `make build`: Compile the contracts.
- `make test`: Run tests.
- `make format`: Format source files using `forge fmt`.
- `make anvil`: Run a local Anvil Ethereum node for testing with a default mnemonic.
- `make deploy-local`: Deploy the `OurToken` contract to a local node using default Anvil key.
- `make deploy-sepolia`: Deploy and verify the contract on the Sepolia testnet. Requires environment variables for RPC, account, sender, and Etherscan API key.
- `make deploy-zk`: Deploy to local zkSync network.
- `make deploy-zk-sepolia`: Deploy to zkSync Sepolia testnet.
- `make verify`: Verify the deployed contract on Etherscan.

Use the `Makefile` commands to streamline your workflow without manually typing long commands.

## License

Licensed under the terms stated in the `LICENSE` or `SEE LICENSE IN LICENSE` references in contract files.

## References

- [Foundry Documentation](https://book.getfoundry.sh/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts)
